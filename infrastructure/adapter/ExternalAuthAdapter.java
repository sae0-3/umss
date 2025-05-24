package infrastructure.adapter;

import java.util.Map;

import domain.model.User;
import domain.service.strategy.AuthenticationStrategy;

public class ExternalAuthAdapter implements AuthenticationStrategy {
  private ExternalAuthService service;

  public ExternalAuthAdapter(ExternalAuthService service) {
    this.service = service;
  }

  @Override
  public boolean authenticate(User user, Map<String, String> credentials) {
    String email = user.getEmail();
    String secret = credentials.getOrDefault("external_secret", "");

    return service.checkCredentials(email, secret);
  }
}
