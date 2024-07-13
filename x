pip install transformers
pip install bert-extractive-summarizer


from summarizer import TransformerSummarizer

# Example text to summarize
text = """
Your text here. This can be a long piece of text that you want to summarize. 
The summarize function will extract the most important sentences from this text.
"""

# BERT
bert_model = TransformerSummarizer(transformer_type="BERT", transformer_model_key="bert-base-uncased")
bert_summary = ''.join(bert_model(text, min_length=30, max_length=130))
print("BERT Summary:")
print(bert_summary)

# GPT-2
gpt2_model = TransformerSummarizer(transformer_type="GPT2", transformer_model_key="gpt2")
gpt2_summary = ''.join(gpt2_model(text, min_length=30, max_length=130))
print("GPT-2 Summary:")
print(gpt2_summary)

# BART
bart_model = TransformerSummarizer(transformer_type="BART", transformer_model_key="facebook/bart-large-cnn")
bart_summary = ''.join(bart_model(text, min_length=30, max_length=130))
print("BART Summary:")
print(bart_summary)

# T5
t5_model = TransformerSummarizer(transformer_type="T5", transformer_model_key="t5-base")
t5_summary = ''.join(t5_model(text, min_length=30, max_length=130))
print("T5 Summary:")
print(t5_summary)

# DistilBERT
distilbert_model = TransformerSummarizer(transformer_type="DistilBERT", transformer_model_key="distilbert-base-uncased")
distilbert_summary = ''.join(distilbert_model(text, min_length=30, max_length=130))
print("DistilBERT Summary:")
print(distilbert_summary)

# RoBERTa
roberta_model = TransformerSummarizer(transformer_type="RoBERTa", transformer_model_key="roberta-base")
roberta_summary = ''.join(roberta_model(text, min_length=30, max_length=130))
print("RoBERTa Summary:")
print(roberta_summary)
