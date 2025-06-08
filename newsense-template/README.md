# Newsense AI Project Template

This is a complete template for AI development projects using the **Newsense structure** with **Believe configurations**.

## Quick Start

1. Copy this template to start a new project:
   ```bash
   cp -r newsense-template my-ai-project
   cd my-ai-project
   ```

2. Install dependencies:
   ```bash
   pip install -r requirements.txt
   ```

3. Set up your environment variables:
   ```bash
   cp .env.example .env
   # Edit .env with your API keys
   ```

4. Run the example:
   ```bash
   python examples/basic_completion.py
   ```

## Project Structure

```
newsense-template/
├── believe/                     # Configuration files
│   ├── model_config.yaml       # Model settings and API configs
│   ├── prompt_templates.yaml   # Reusable prompt templates
│   └── logging_config.yaml     # Logging configuration
├── src/
│   ├── llm/                     # LLM client implementations
│   │   ├── __init__.py
│   │   ├── base.py             # Base LLM client class
│   │   ├── claude_client.py    # Claude API client
│   │   ├── gpt_client.py       # OpenAI GPT client
│   │   └── utils.py            # LLM utilities
│   ├── prompt_engineering/      # Prompt engineering tools
│   │   ├── __init__.py
│   │   ├── templates.py        # Template management
│   │   ├── few_shot.py         # Few-shot learning utilities
│   │   └── chainer.py          # Chain-of-thought prompting
│   └── utils/                   # General utilities
│       ├── __init__.py
│       ├── rate_limiter.py     # API rate limiting
│       ├── token_counter.py    # Token counting utilities
│       ├── cache.py            # Response caching
│       └── logger.py           # Logging utilities
├── handlers/
│   ├── __init__.py
│   └── error_handler.py        # Error handling framework
├── data/                        # Data storage
│   ├── cache/                  # Cached responses
│   ├── prompts/                # Prompt files
│   ├── outputs/                # Generated outputs
│   └── embeddings/             # Vector embeddings
├── examples/                    # Usage examples
│   ├── basic_completion.py     # Simple completion example
│   ├── chat_session.py         # Chat interface example
│   └── chain_prompts.py        # Chain prompting example
├── notebooks/                   # Jupyter notebooks
│   ├── prompt_testing.ipynb    # Prompt testing and iteration
│   ├── response_analysis.ipynb # Response quality analysis
│   └── model_experimentation.ipynb # Model comparison
├── requirements.txt            # Python dependencies
├── setup.py                    # Package setup
├── .env.example               # Environment variables template
├── .gitignore                 # Git ignore patterns
├── Dockerfile                 # Docker configuration
└── README.md                  # This file
```

## Configuration

### Environment Variables
Set these in your `.env` file:
- `ANTHROPIC_API_KEY` - Your Claude API key
- `OPENAI_API_KEY` - Your OpenAI API key
- `LOG_LEVEL` - Logging level (DEBUG, INFO, WARNING, ERROR)

### Model Configuration
Edit `believe/model_config.yaml` to customize:
- Model selection and parameters
- Rate limiting settings
- Caching preferences
- Retry strategies

## Development Guidelines

1. **Use the believe configs** for all settings
2. **Implement proper error handling** with the handlers module
3. **Cache responses** to reduce API costs
4. **Respect rate limits** with built-in limiters
5. **Log everything** for debugging and monitoring
6. **Version your prompts** in the data/prompts directory

## Docker Support

Build and run with Docker:
```bash
docker build -t my-ai-project .
docker run -p 8000:8000 my-ai-project
```

## Testing

Run the examples to test your setup:
```bash
python examples/basic_completion.py
python examples/chat_session.py
python examples/chain_prompts.py
```

---

Built with the **Newsense AI structure** for **Supabowl development** 🤖✨
