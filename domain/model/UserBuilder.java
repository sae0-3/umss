package domain.model;

public class UserBuilder {
  private final User user = new User();

  public UserBuilder withUsername(String username) {
    user.setUsername(username);
    return this;
  }

  public UserBuilder withEmail(String email) {
    user.setEmail(email);
    return this;
  }

  public UserBuilder withPassword(String password) {
    user.setPassword(password);
    return this;
  }

  public UserBuilder withRole(UserRole role) {
    user.setRole(role);
    return this;
  }

  public UserBuilder isVerified(boolean verified) {
    user.setVerified(verified);
    return this;
  }

  public UserBuilder withVerificationCode(String code) {
    user.setVerificationCode(code);
    return this;
  }

  public User build() {
    if (user.getUsername() == null || user.getUsername().isEmpty()) {
      throw new IllegalStateException("El username es obligatorio");
    }

    if (user.getRole() == null) {
      user.setRole(UserRole.GUEST);
    }

    return user;
  }
}
