import java.util.HashMap;
import java.util.Map;

import infrastructure.adapter.*;
import domain.model.*;
import domain.service.*;
import domain.service.strategy.*;

public class Main {
  public static void main(String[] args) {
    User guest = new UserBuilder()
        .withUsername("guest_user")
        .withEmail("guest@example.com")
        .withRole(UserRole.GUEST)
        .build();

    User verifiedUser = new UserBuilder()
        .withUsername("robert")
        .withEmail("roberto@example.com")
        .withPassword("secure123")
        .isVerified(true)
        .withRole(UserRole.READER)
        .build();

    User codeUser = new UserBuilder()
        .withUsername("sofi")
        .withEmail("sofia@example.com")
        .withVerificationCode("ABC123")
        .withRole(UserRole.EDITOR)
        .build();

    User externalUser = new UserBuilder()
        .withUsername("carlos")
        .withEmail("carlos@example.com")
        .withRole(UserRole.ADMIN)
        .build();

    AuthenticationContext context = new AuthenticationContext();

    context.setStrategy(new NoVerificationAuthentication());
    System.out.println("Autenticación sin verificación:");
    System.out.println("Guest autenticado: " + context.executeAuthentication(guest, new HashMap<>()));

    System.out.println();

    context.setStrategy(new PasswordAuthentication());
    Map<String, String> passwordCredentials = new HashMap<>();
    passwordCredentials.put("password", "secure123");
    System.out.println("Autenticación con contraseña:");
    System.out.println("Roberto autenticado: " + context.executeAuthentication(verifiedUser, passwordCredentials));

    System.out.println();

    context.setStrategy(new VerificationCodeAuthentication());
    Map<String, String> codeCredentials = new HashMap<>();
    codeCredentials.put("code", "ABC123");
    System.out.println("Autenticación con código de verificación:");
    System.out.println("Sofia autenticada: " + context.executeAuthentication(codeUser, codeCredentials));

    System.out.println();

    context.setStrategy(new ExternalAuthAdapter(new ExternalAuthService()));
    Map<String, String> externalCredentials = new HashMap<>();
    externalCredentials.put("external_secret", "ext-password");
    System.out.println("Autenticación con método externo::");
    System.out.println("Carlos autenticado: " + context.executeAuthentication(externalUser, externalCredentials));
  }
}
