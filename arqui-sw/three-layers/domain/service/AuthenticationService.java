package domain.service;

import domain.model.User;
import domain.service.strategy.*;
import infrastructure.adapter.ExternalAuthAdapter;
import infrastructure.adapter.ExternalAuthService;

import java.util.Map;

public class AuthenticationService {
  private final AuthenticationContext authContext;

  public AuthenticationService(AuthenticationContext authContext) {
    this.authContext = authContext;
  }

  public boolean authenticate(User user, String method, Map<String, String> credentials) {
    switch (method.toLowerCase()) {
      case "password":
        authContext.setStrategy(new PasswordAuthentication());
        break;
      case "code":
        authContext.setStrategy(new VerificationCodeAuthentication());
        break;
      case "external":
        authContext.setStrategy(new ExternalAuthAdapter(new ExternalAuthService()));
        break;
      default:
        authContext.setStrategy(new NoVerificationAuthentication());
    }

    return authContext.executeAuthentication(user, credentials);
  }
}
