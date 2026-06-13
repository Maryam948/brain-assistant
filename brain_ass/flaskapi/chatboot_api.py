# chatbot_api.py
from flask import Flask, request, jsonify
from sentence_transformers import SentenceTransformer
import faiss
import numpy as np
import json
import os

app = Flask(__name__)

# ── Load dataset ─────────────────────────────────────
DATASET_PATH = "D:/Downloads/dataset.json"

with open(DATASET_PATH, "r", encoding="utf-8") as f:
    dataset = json.load(f)

# ── Load embedding model ─────────────────────────────
print("Loading embedding model...")
embed_model = SentenceTransformer("paraphrase-multilingual-MiniLM-L12-v2")

# ── Build FAISS index ────────────────────────────────
texts = [item["text"] for item in dataset]
embeddings = embed_model.encode(texts).astype("float32")
faiss.normalize_L2(embeddings)

index = faiss.IndexFlatIP(embeddings.shape[1])
index.add(embeddings)
print(f"FAISS index ready with {len(texts)} entries.")

# ── Retrieve top-k docs ──────────────────────────────
def retrieve(query, k=3):
    q_emb = embed_model.encode([query]).astype("float32")
    faiss.normalize_L2(q_emb)
    D, I = index.search(q_emb, k)
    return [dataset[i] for i in I[0]]

# ── Generate answer (rule-based, no LLM needed locally) ──
def generate_answer(query, docs):
    context = "\n".join([d["text"] for d in docs])
    diseases = list(set([d.get("disease", "unknown") for d in docs]))

    # Simple answer: return the most relevant context sentence
    answer = docs[0]["text"] if docs else "Sorry, I couldn't find relevant information."

    return {
        "answer": answer,
        "context": context,
        "sources": [d["text"] for d in docs],
        "diseases": diseases
    }

# ── API endpoint ─────────────────────────────────────
@app.route('/chat', methods=['POST'])
def chat():
    try:
        data = request.json
        query = data.get("query", "").strip()

        if not query:
            return jsonify({"error": "Query is empty"}), 400

        docs = retrieve(query, k=3)
        result = generate_answer(query, docs)

        return jsonify(result)

    except Exception as e:
        import traceback
        traceback.print_exc()
        return jsonify({"error": str(e)}), 500

@app.route('/health', methods=['GET'])
def health():
    return jsonify({"status": "ok", "entries": len(dataset)})

if __name__ == "__main__":
    app.run(debug=True, host="0.0.0.0", port=5001)