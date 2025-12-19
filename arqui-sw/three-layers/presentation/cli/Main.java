package presentation.cli;

import domain.service.AuthenticationContext;
import domain.service.AuthenticationService;

public class Main {
  public static void main(String[] args) {
    AuthenticationService authService = new AuthenticationService(new AuthenticationContext());

    AuthConsoleController controller = new AuthConsoleController(authService);
    controller.start();
  }
}
