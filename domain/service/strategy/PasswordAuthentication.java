package domain.service.strategy;

import java.util.Map;

import domain.model.User;

public class PasswordAuthentication implements AuthenticationStrategy {
  @Override
  public boolean authenticate(User user, Map<String, String> credentials) {
    String password = credentials.getOrDefault("password", "");

    return user.getPassword() != null &&
        user.getPassword().equals(password) &&
        user.isVerified();
  }
}
