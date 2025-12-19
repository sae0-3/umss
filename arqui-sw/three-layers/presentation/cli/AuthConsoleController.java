package presentation.cli;

import domain.model.User;
import domain.model.UserBuilder;
import domain.service.AuthenticationService;
import java.util.HashMap;
import java.util.Map;

public class AuthConsoleController {
  private final AuthenticationService authService;

  public AuthConsoleController(AuthenticationService authService) {
    this.authService = authService;
  }

  public void start() {
    User user = new UserBuilder()
        .withUsername("user123")
        .withEmail("user@example.com")
        .withPassword("123")
        .isVerified(true)
        .build();

    // ***** PETICIÓN DE DATOS *****
    Map<String, String> credentials = new HashMap<>();
    credentials.put("password", "123");
    // ***** FIN DE PETICIÓN DE DATOS *****

    boolean success = authService.authenticate(user, "password", credentials);
    System.out.println("Autenticación exitosa: " + success);
  }
}
