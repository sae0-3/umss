package domain.service;

import java.util.Map;

import domain.model.User;
import domain.service.strategy.AuthenticationStrategy;

public class AuthenticationContext {
  private AuthenticationStrategy strategy;

  public void setStrategy(AuthenticationStrategy strategy) {
    this.strategy = strategy;
  }

  public boolean executeAuthentication(User user, Map<String, String> credentials) {
    if (strategy == null) {
      throw new IllegalStateException("Strategy no definida");
    }

    return strategy.authenticate(user, credentials);
  }
}
