# Deploy BERT for Sentiment Analsysi with FastAPI

Deploy a pre-trained BERT model for Sentiment Analysis as a REST API using FastAPI

## Demo

The model is trained to classify sentiment (negative, neutral, and positive) on a custom dataset from app reviews on Google Play. Here's a sample request to the API:

```bash
http POST http://127.0.0.1:8000/predict text="Good basic lists, i would like to create more lists, but the annual fee for unlimited lists is too out there"
```

The response you'll get looks something like this:

```js
{
    "confidence": 0.9999083280563354,
    "probabilities": {
        "negative": 3.563107020454481e-05,
        "neutral": 0.9999083280563354,
        "positive": 5.596495248028077e-05
    },
    "sentiment": "neutral"
}
```

You can also [read the complete tutorial here](https://www.curiousily.com/posts/deploy-bert-for-sentiment-analysis-as-rest-api-using-pytorch-transformers-by-hugging-face-and-fastapi/)

## Installation

Clone this repo:

```sh
git clone https://github.com/Raion-App-Programmer/Deploy-BERT-Sentiment-Analysis-Docker.git
cd Deploy-BERT-Sentiment-Analysis-Docker
```

## Running it via Docker Compose

Build and run with docker-compose (this will also download the model into `./assets` if missing):

```bash
docker compose up --build
```

After the container is ready, the API docs will be available at:

- http://localhost:8000/docs

Test with curl (Linux):

```bash
curl -sS -X POST "http://localhost:8000/predict" \
    -H "Content-Type: application/json" \
    -d '{"text":"This app is a total waste of time!"}' | jq
```

Test with PowerShell (Windows):

```powershell
curl.exe -sS -X POST "http://localhost:8000/predict" `
    -H "Content-Type: application/json" `
    -d '{ "text": "This app is a total waste of time!" }' | ConvertFrom-Json
```

## Notes

- The Docker image installs CPU PyTorch by default. If you need GPU support, update the Dockerfile and install a CUDA-enabled PyTorch wheel (and use the NVIDIA container runtime).
- I updated the code to be compatible with newer `transformers` outputs (pooled output extraction). If you maintain a specific `transformers` version, pin it in `requirements.txt`.

## License

MIT
