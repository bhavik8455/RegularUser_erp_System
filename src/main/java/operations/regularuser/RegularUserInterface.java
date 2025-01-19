package operations.regularuser;

import model.UserPojo;

public interface RegularUserInterface {
    UserPojo getUserById(int userId);
    boolean updateUserDetails(int userId, String name, String email);
}
