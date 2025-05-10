package strategy;

import java.util.Map;

import builder.User;

public interface AuthenticationStrategy {
  public boolean authenticate(User user, Map<String, String> credentials);
}
