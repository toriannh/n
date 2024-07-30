### Detailed Summary of the 10Q Summarization Model

#### Introduction

During my summer internship at the Federal Reserve, I was tasked with developing a model to summarize 10Q financial statements filed with the SEC. This model aims to extract the most relevant information from these lengthy documents and present it in a concise and understandable format. The summarization model combines both extractive and abstractive summarization techniques to achieve this goal. Below is a detailed overview of the development process, methodologies, and results of the summarization model.

#### Objectives

The primary objectives of this project were:
1. To develop an extractive summarization model that identifies and extracts sentences with the greatest relevancy and importance from 10Q financial statements.
2. To enhance the extracted sentences using abstractive summarization models to provide more coherent and concise summaries.
3. To create a pipeline that can be used to consistently generate summaries from multiple 10Q documents.

#### Data Collection and Preprocessing

The first step in developing the summarization model involved collecting and preprocessing the data. 10Q documents were obtained in HTML format from the SEC’s EDGAR database. The key stages in data preprocessing included:

1. **HTML Parsing**: Using BeautifulSoup, the HTML documents were parsed to extract text content, specifically focusing on paragraphs with a font size of 10pt, which typically contain key financial information.
2. **Text Cleaning**: The extracted text was cleaned to remove any extraneous characters, extra whitespace, and irrelevant HTML tags.

```python
import requests
from bs4 import BeautifulSoup
import re

def extract_text_with_font_size(soup, font_size='10pt'):
    elements = soup.find_all(lambda tag: tag.has_attr('style') and f'font-size: {font_size}' in tag['style'])
    text_content = [element.get_text(separator=' ') for element in elements]
    combined_text = ' '.join(text_content)
    cleaned_text = re.sub('\s+', ' ', combined_text).strip()
    return cleaned_text

# Example usage
url = 'https://www.example.com/sample.html'
response = requests.get(url)
html_content = response.content
soup = BeautifulSoup(html_content, 'html.parser')
output = extract_text_with_font_size(soup, '10pt')
```

#### Extractive Summarization

The next step involved developing an extractive summarization model that highlights the most relevant and important sentences from the preprocessed text. Key components of this stage included:

1. **Keyword Identification**: Using regular expressions and NLP techniques, key paragraphs related to risk factors, cash flow, and balance sheet data were identified.
2. **Sentence Extraction**: Sentences containing the identified keywords were extracted. NLTK’s `sent_tokenize` was used to split the text into sentences, and relevant sentences were selected based on the presence of the keywords.

```python
import nltk
nltk.download('punkt')
from nltk.tokenize import sent_tokenize

def extract_key_sentences(text):
    sentences = sent_tokenize(text)
    risk_keywords = r'\b(risk|uncertainty|contingency|exposure)\b'
    cashflow_keywords = r'\b(cash flow|cash flows|operating activities|financing activities|investing activities)\b'
    balance_sheet_keywords = r'\b(balance sheet|assets|liabilities|equity)\b'
    
    risk_sentences = [sent for sent in sentences if re.search(risk_keywords, sent, re.IGNORECASE)]
    cashflow_sentences = [sent for sent in sentences if re.search(cashflow_keywords, sent, re.IGNORECASE)]
    balance_sheet_sentences = [sent for sent in sentences if re.search(balance_sheet_keywords, sent, re.IGNORECASE)]
    
    key_sentences = risk_sentences + cashflow_sentences + balance_sheet_sentences
    return key_sentences
```

#### Extractive Summarization Algorithms Used

Several extractive summarization algorithms were considered and tested to identify the most relevant sentences in the 10Q documents. The main algorithms used include:

1. **TF-IDF (Term Frequency-Inverse Document Frequency)**: This algorithm scores the importance of a sentence based on the frequency of terms within the document and the rarity of those terms across all documents.
2. **LexRank**: An unsupervised algorithm based on graph-based centrality scoring, which measures the importance of a sentence by considering its similarity to other sentences.
3. **TextRank**: Another graph-based ranking algorithm inspired by Google's PageRank, which identifies the most important sentences by analyzing the connections (similarities) between them.
4. **LDA (Latent Dirichlet Allocation)**: A topic modeling algorithm that helps in identifying sentences that best represent the underlying topics within the document.
5. **BERT-based Extractive Summarizer**: Utilizes BERT embeddings to understand the context and meaning of sentences, allowing for more accurate extraction of relevant sentences.

#### Abstractive Summarization

Once the relevant sentences were extracted, the next step was to enhance them using abstractive summarization models. The goal was to produce a more coherent and readable summary. Several transformer models were considered, including BERT, GPT-2, BART, T5, DistilBERT, and RoBERTa. The `transformers` library from Hugging Face was used to implement these models.

1. **Model Selection**: The following models were selected for summarization:
   - BERT: `"bert-base-uncased"`
   - GPT-2: `"gpt2"`
   - BART: `"facebook/bart-large-cnn"`
   - T5: `"t5-base"`
   - DistilBERT: `"distilbert-base-uncased"`
   - RoBERTa: `"roberta-base"`

2. **Implementation**: The `TransformerSummarizer` class from the `bert-extractive-summarizer` library was used to apply these models.

```python
from summarizer import TransformerSummarizer

# Example text
text = "Your text here. This can be a long piece of text that you want to summarize."

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
```

#### Results and Analysis

The results of the abstractive summarization models were compiled into an Excel spreadsheet named "Abstract_results.xlsx". Each column in the spreadsheet represents a different summarization model, and the subsequent rows contain the summaries generated by each model.

1. **Comparison of Models**: The performance of each model was analyzed based on the coherence, readability, and informativeness of the summaries.
2. **Feedback and Iteration**: The initial results were reviewed, and feedback was provided by the team. The pipeline was iteratively improved to enhance the extraction and summarization process.

#### Future Work

While the initial results are promising, there are several areas for further improvement:

1. **Enhanced Extraction**: Improve the pipeline to better identify and extract sentences that provide deeper insights and valuable context from the 10Q documents.
2. **Model Fine-Tuning**: Fine-tune the abstractive summarization models on a dataset of financial documents to improve their performance.
3. **Automated Evaluation**: Develop automated evaluation metrics to assess the quality of the summaries more objectively.

#### Conclusion

The summarization model developed during this internship combines extractive and abstractive summarization techniques to provide concise and coherent summaries of 10Q financial statements. The model leverages state-of-the-art transformer models to achieve this goal. While there is room for further improvement, the current results demonstrate the potential of using NLP techniques to automate the summarization of complex financial documents.

I look forward to any feedback and suggestions for further enhancing the summarization model.

Thank you for the opportunity to work on this project.

Best regards,

Tori-Ann Holness
