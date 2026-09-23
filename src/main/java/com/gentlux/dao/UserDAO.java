package com.gentlux.dao;

import com.gentlux.model.User;
import java.util.List;

public interface UserDAO {

    boolean registerUser(User user);

    User getUserById(int userId);

    User getUserByEmail(String email);

    boolean isEmailExists(String email);

    boolean isPhoneExists(String phone);

    boolean updateUser(User user);

    boolean updatePassword(int userId, String newPassword);

    boolean updateAddress(User user);

    boolean deleteUser(int userId);

    List<User> getAllUsers();
}