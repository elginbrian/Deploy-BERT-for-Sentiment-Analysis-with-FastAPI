import json

from torch import nn
from transformers import BertModel

with open("config.json") as json_file:
    config = json.load(json_file)


class SentimentClassifier(nn.Module):
    def __init__(self, n_classes):
        super(SentimentClassifier, self).__init__()
        self.bert = BertModel.from_pretrained(config["BERT_MODEL"])
        self.drop = nn.Dropout(p=0.3)
        self.out = nn.Linear(self.bert.config.hidden_size, n_classes)

    def forward(self, input_ids, attention_mask):
        bert_outputs = self.bert(input_ids=input_ids, attention_mask=attention_mask)

        pooled_output = None
        if isinstance(bert_outputs, tuple):
            if len(bert_outputs) > 1:
                pooled_output = bert_outputs[1]
        else:
            pooled_output = getattr(bert_outputs, "pooler_output", None)

        if pooled_output is None:
            last_hidden = bert_outputs[0] if isinstance(bert_outputs, tuple) else bert_outputs.last_hidden_state
            pooled_output = last_hidden[:, 0]

        output = self.drop(pooled_output)
        return self.out(output)
