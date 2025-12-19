package domain.service.strategy;

import java.util.Map;

import domain.model.User;

public class VerificationCodeAuthentication implements AuthenticationStrategy {
  @Override
  public boolean authenticate(User user, Map<String, String> credentials) {
    String code = credentials.getOrDefault("code", "");

    return user.getVerificationCode() != null &&
        user.getVerificationCode().equals(code);
  }
}
