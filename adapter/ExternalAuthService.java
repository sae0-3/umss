package adapter;

public class ExternalAuthService {
  public boolean checkCredentials(String email, String secret) {
    return email.equals("email@example.com") && secret.equals("0000");
  }
}
