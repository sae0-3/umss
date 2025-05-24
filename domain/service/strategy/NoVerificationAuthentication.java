package domain.service.strategy;

import java.util.Map;

import domain.model.User;

public class NoVerificationAuthentication implements AuthenticationStrategy {
  @Override
  public boolean authenticate(User user, Map<String, String> credentials) {
    return true;
  }
}
