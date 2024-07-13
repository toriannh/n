from transformers import pipeline

# Example text to summarize
text = """
Your text here. This can be a long piece of text that you want to summarize. 
The summarize function will extract the most important sentences from this text.
"""

# GPT-2
summarizer_gpt2 = pipeline("summarization", model="gpt2")
summary_gpt2 = summarizer_gpt2(text, max_length=130, min_length=30, do_sample=False)
print("GPT-2 Summary:")
print(summary_gpt2)

# BERT
summarizer_bert = pipeline("summarization", model="bert-base-uncased")
summary_bert = summarizer_bert(text, max_length=130, min_length=30, do_sample=False)
print("BERT Summary:")
print(summary_bert)

# BART
summarizer_bart = pipeline("summarization", model="facebook/bart-large-cnn")
summary_bart = summarizer_bart(text, max_length=130, min_length=30, do_sample=False)
print("BART Summary:")
print(summary_bart)

# T5
summarizer_t5 = pipeline("summarization", model="t5-base")
summary_t5 = summarizer_t5(text, max_length=130, min_length=30, do_sample=False)
print("T5 Summary:")
print(summary_t5)

# DistilBERT
summarizer_distilbart = pipeline("summarization", model="sshleifer/distilbart-cnn-12-6")
summary_distilbart = summarizer_distilbart(text, max_length=130, min_length=30, do_sample=False)
print("DistilBERT Summary:")
print(summary_distilbart)

# PEGASUS
summarizer_pegasus = pipeline("summarization", model="google/pegasus-xsum")
summary_pegasus = summarizer_pegasus(text, max_length=130, min_length=30, do_sample=False)
print("PEGASUS Summary:")
print(summary_pegasus)
