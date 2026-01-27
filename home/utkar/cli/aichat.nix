{...}: {
  programs.aichat = {
    enable = true;
    settings = {
      model = "mistral:mistral-small3.1:latest";
      clients = [
        {
          type = "openai-compatible";
          name = "mistral";
          api_base = "https://api.mistral.ai/v1";
          models = [
            {
              name = "mistral-large-3";
              # supports_function_calling = true;
              # supports_vision = true;
            }
          ];
        }
      ];
    };
  };
}
