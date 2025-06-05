#!/usr/bin/env python3
"""
Basic completion example for Newsense AI project template.

This example demonstrates:
- Loading believe configuration
- Creating an AI client (Claude or OpenAI)
- Making a simple completion request
- Handling responses and errors

Run this after setting up your environment and API keys.
"""

import os
import sys
from pathlib import Path

# Add the src directory to the Python path
project_root = Path(__file__).parent.parent
sys.path.insert(0, str(project_root / "src"))

from dotenv import load_dotenv
import yaml
from llm.claude_client import ClaudeClient
from llm.gpt_client import GPTClient

def load_config():
    """Load configuration from believe/model_config.yaml"""
    config_path = project_root / "believe" / "model_config.yaml"
    with open(config_path, 'r') as f:
        return yaml.safe_load(f)

def main():
    """Run basic completion example"""
    # Load environment variables
    load_dotenv()
    
    print("🤖 Newsense AI Basic Completion Example")
    print("=" * 50)
    
    # Load configuration
    try:
        config = load_config()
        print("✅ Configuration loaded successfully")
    except Exception as e:
        print(f"❌ Error loading configuration: {e}")
        return
    
    # Check for API keys
    anthropic_key = os.getenv("ANTHROPIC_API_KEY")
    openai_key = os.getenv("OPENAI_API_KEY")
    
    if not anthropic_key and not openai_key:
        print("❌ No API keys found. Please set ANTHROPIC_API_KEY or OPENAI_API_KEY in your .env file")
        return
    
    # Choose client based on available keys
    if anthropic_key:
        print("🔵 Using Claude client")
        client = ClaudeClient(config["models"]["claude"])
        model_name = "Claude"
    elif openai_key:
        print("🟢 Using OpenAI client") 
        client = GPTClient(config["models"]["openai"])
        model_name = "GPT"
    
    # Test prompt
    prompt = "Hello! Please introduce yourself and explain what you can help with in AI development projects."
    
    print(f"\n📝 Sending prompt to {model_name}:")
    print(f"'{prompt}'")
    print("\n⏳ Waiting for response...")
    
    try:
        # Make the completion request
        response = client.complete(prompt)
        
        print(f"\n✅ Response from {model_name}:")
        print("-" * 50)
        print(response)
        print("-" * 50)
        
        # Save response to outputs directory
        output_dir = project_root / "data" / "outputs"
        output_dir.mkdir(parents=True, exist_ok=True)
        
        output_file = output_dir / f"basic_completion_{model_name.lower()}.txt"
        with open(output_file, 'w') as f:
            f.write(f"Prompt: {prompt}\n\n")
            f.write(f"Response: {response}\n")
        
        print(f"💾 Response saved to: {output_file}")
        
    except Exception as e:
        print(f"❌ Error making completion request: {e}")
        return
    
    print("\n🎉 Basic completion example completed successfully!")
    print("Next steps:")
    print("- Try the chat_session.py example")
    print("- Modify the believe/model_config.yaml settings")
    print("- Explore the notebooks/ directory")

if __name__ == "__main__":
    main()
