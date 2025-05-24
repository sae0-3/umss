package domain.service.strategy;

import java.util.Map;

import domain.model.User;

public interface AuthenticationStrategy {
  public boolean authenticate(User user, Map<String, String> credentials);
}
