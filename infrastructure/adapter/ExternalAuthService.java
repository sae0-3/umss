package infrastructure.adapter;

public class ExternalAuthService implements ExternalAuthProvider {
  @Override
  public boolean checkCredentials(String email, String secret) {
    return email.equals("email@example.com") && secret.equals("0000");
  }
}
