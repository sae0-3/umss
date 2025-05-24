package infrastructure.adapter;

public interface ExternalAuthProvider {
  boolean checkCredentials(String email, String secret);
}
