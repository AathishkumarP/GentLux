package com.gentlux.dao.impl;

import com.gentlux.dao.UserDAO;
import com.gentlux.model.User;
import com.gentlux.util.DBConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;


public class UserDAOImpl implements UserDAO {


    // =========================================================
    // REGISTER USER
    // =========================================================

    @Override
    public boolean registerUser(User user) {

        String sql =
                "INSERT INTO users "
              + "(full_name, email, phone, password, "
              + "address, city, state, pincode) "
              + "VALUES (?, ?, ?, ?, ?, ?, ?, ?)";

        try (
            Connection connection =
                    DBConnection.getConnection();

            PreparedStatement statement =
                    connection.prepareStatement(sql)
        ) {

            statement.setString(
                    1,
                    user.getFullName()
            );

            statement.setString(
                    2,
                    user.getEmail()
            );

            statement.setString(
                    3,
                    user.getPhone()
            );

            statement.setString(
                    4,
                    user.getPassword()
            );

            statement.setString(
                    5,
                    user.getAddress()
            );

            statement.setString(
                    6,
                    user.getCity()
            );

            statement.setString(
                    7,
                    user.getState()
            );

            statement.setString(
                    8,
                    user.getPincode()
            );

            return statement.executeUpdate() > 0;

        } catch (Exception e) {

            e.printStackTrace();
        }

        return false;
    }


    // =========================================================
    // GET USER BY ID
    // =========================================================

    @Override
    public User getUserById(int userId) {

        String sql =
                "SELECT * FROM users "
              + "WHERE user_id = ?";

        try (
            Connection connection =
                    DBConnection.getConnection();

            PreparedStatement statement =
                    connection.prepareStatement(sql)
        ) {

            statement.setInt(
                    1,
                    userId
            );

            try (
                ResultSet resultSet =
                        statement.executeQuery()
            ) {

                if (resultSet.next()) {

                    return mapUser(
                            resultSet
                    );
                }
            }

        } catch (Exception e) {

            e.printStackTrace();
        }

        return null;
    }


    // =========================================================
    // GET USER BY EMAIL
    // =========================================================

    @Override
    public User getUserByEmail(String email) {

        String sql =
                "SELECT * FROM users "
              + "WHERE email = ?";

        try (
            Connection connection =
                    DBConnection.getConnection();

            PreparedStatement statement =
                    connection.prepareStatement(sql)
        ) {

            statement.setString(
                    1,
                    email
            );

            try (
                ResultSet resultSet =
                        statement.executeQuery()
            ) {

                if (resultSet.next()) {

                    return mapUser(
                            resultSet
                    );
                }
            }

        } catch (Exception e) {

            e.printStackTrace();
        }

        return null;
    }


    // =========================================================
    // CHECK EMAIL EXISTS
    // =========================================================

    @Override
    public boolean isEmailExists(String email) {

        String sql =
                "SELECT 1 FROM users "
              + "WHERE email = ?";

        try (
            Connection connection =
                    DBConnection.getConnection();

            PreparedStatement statement =
                    connection.prepareStatement(sql)
        ) {

            statement.setString(
                    1,
                    email
            );

            try (
                ResultSet resultSet =
                        statement.executeQuery()
            ) {

                return resultSet.next();
            }

        } catch (Exception e) {

            e.printStackTrace();
        }

        return false;
    }


    // =========================================================
    // CHECK PHONE EXISTS
    // =========================================================

    @Override
    public boolean isPhoneExists(String phone) {

        String sql =
                "SELECT 1 FROM users "
              + "WHERE phone = ?";

        try (
            Connection connection =
                    DBConnection.getConnection();

            PreparedStatement statement =
                    connection.prepareStatement(sql)
        ) {

            statement.setString(
                    1,
                    phone
            );

            try (
                ResultSet resultSet =
                        statement.executeQuery()
            ) {

                return resultSet.next();
            }

        } catch (Exception e) {

            e.printStackTrace();
        }

        return false;
    }


    // =========================================================
    // UPDATE USER
    // =========================================================

    @Override
    public boolean updateUser(User user) {

        String sql =
                "UPDATE users SET "
              + "full_name = ?, "
              + "email = ?, "
              + "phone = ? "
              + "WHERE user_id = ?";

        try (
            Connection connection =
                    DBConnection.getConnection();

            PreparedStatement statement =
                    connection.prepareStatement(sql)
        ) {

            statement.setString(
                    1,
                    user.getFullName()
            );

            statement.setString(
                    2,
                    user.getEmail()
            );

            statement.setString(
                    3,
                    user.getPhone()
            );

            statement.setInt(
                    4,
                    user.getUserId()
            );

            return statement.executeUpdate() > 0;

        } catch (Exception e) {

            e.printStackTrace();
        }

        return false;
    }


    // =========================================================
    // UPDATE PASSWORD
    // =========================================================

    @Override
    public boolean updatePassword(
            int userId,
            String newPassword) {

        String sql =
                "UPDATE users SET "
              + "password = ? "
              + "WHERE user_id = ?";

        try (
            Connection connection =
                    DBConnection.getConnection();

            PreparedStatement statement =
                    connection.prepareStatement(sql)
        ) {

            statement.setString(
                    1,
                    newPassword
            );

            statement.setInt(
                    2,
                    userId
            );

            return statement.executeUpdate() > 0;

        } catch (Exception e) {

            e.printStackTrace();
        }

        return false;
    }


    // =========================================================
    // UPDATE ADDRESS
    // =========================================================

    @Override
    public boolean updateAddress(User user) {

        String sql =
                "UPDATE users SET "
              + "address = ?, "
              + "city = ?, "
              + "state = ?, "
              + "pincode = ? "
              + "WHERE user_id = ?";

        try (
            Connection connection =
                    DBConnection.getConnection();

            PreparedStatement statement =
                    connection.prepareStatement(sql)
        ) {

            statement.setString(
                    1,
                    user.getAddress()
            );

            statement.setString(
                    2,
                    user.getCity()
            );

            statement.setString(
                    3,
                    user.getState()
            );

            statement.setString(
                    4,
                    user.getPincode()
            );

            statement.setInt(
                    5,
                    user.getUserId()
            );

            return statement.executeUpdate() > 0;

        } catch (Exception e) {

            e.printStackTrace();
        }

        return false;
    }


    // =========================================================
    // DELETE USER
    // =========================================================

    @Override
    public boolean deleteUser(int userId) {

        String sql =
                "DELETE FROM users "
              + "WHERE user_id = ?";

        try (
            Connection connection =
                    DBConnection.getConnection();

            PreparedStatement statement =
                    connection.prepareStatement(sql)
        ) {

            statement.setInt(
                    1,
                    userId
            );

            return statement.executeUpdate() > 0;

        } catch (Exception e) {

            e.printStackTrace();
        }

        return false;
    }


    // =========================================================
    // GET ALL USERS
    // =========================================================

    @Override
    public List<User> getAllUsers() {

        List<User> users =
                new ArrayList<>();

        String sql =
                "SELECT * FROM users "
              + "ORDER BY user_id DESC";

        try (
            Connection connection =
                    DBConnection.getConnection();

            PreparedStatement statement =
                    connection.prepareStatement(sql);

            ResultSet resultSet =
                    statement.executeQuery()
        ) {

            while (resultSet.next()) {

                users.add(
                        mapUser(resultSet)
                );
            }

        } catch (Exception e) {

            e.printStackTrace();
        }

        return users;
    }


    // =========================================================
    // MAP RESULTSET TO USER OBJECT
    // =========================================================

    private User mapUser(
            ResultSet resultSet)
            throws Exception {

        User user =
                new User();


        user.setUserId(
                resultSet.getInt(
                        "user_id"
                )
        );


        user.setFullName(
                resultSet.getString(
                        "full_name"
                )
        );


        user.setEmail(
                resultSet.getString(
                        "email"
                )
        );


        user.setPhone(
                resultSet.getString(
                        "phone"
                )
        );


        user.setPassword(
                resultSet.getString(
                        "password"
                )
        );


        user.setAddress(
                resultSet.getString(
                        "address"
                )
        );


        user.setCity(
                resultSet.getString(
                        "city"
                )
        );


        user.setState(
                resultSet.getString(
                        "state"
                )
        );


        user.setPincode(
                resultSet.getString(
                        "pincode"
                )
        );


        // =====================================================
        // NEW ROLE FIELD
        // =====================================================

        user.setRole(
                resultSet.getString(
                        "role"
                )
        );


        user.setCreatedAt(
                resultSet.getTimestamp(
                        "created_at"
                )
        );


        return user;
    }
}