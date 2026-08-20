package com.gentlux.dao.impl;

import com.gentlux.dao.OrderDAO;
import com.gentlux.model.Order;
import com.gentlux.util.DBConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.sql.Timestamp;

import java.util.ArrayList;
import java.util.List;


public class OrderDAOImpl implements OrderDAO {


    // =========================================================
    // 1. CREATE ORDER
    // =========================================================

    @Override
    public int createOrder(Order order) {

        String sql =
                "INSERT INTO orders "
              + "(user_id, total_amount, payment_method, "
              + "payment_status, order_status, shipping_name, "
              + "shipping_phone, shipping_address, shipping_city, "
              + "shipping_state, shipping_pincode) "
              + "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

        try (
            Connection connection =
                    DBConnection.getConnection();

            PreparedStatement statement =
                    connection.prepareStatement(
                            sql,
                            Statement.RETURN_GENERATED_KEYS
                    )
        ) {

            statement.setInt(
                    1,
                    order.getUserId()
            );

            statement.setDouble(
                    2,
                    order.getTotalAmount()
            );

            statement.setString(
                    3,
                    order.getPaymentMethod()
            );

            statement.setString(
                    4,
                    order.getPaymentStatus()
            );

            statement.setString(
                    5,
                    order.getOrderStatus()
            );

            statement.setString(
                    6,
                    order.getShippingName()
            );

            statement.setString(
                    7,
                    order.getShippingPhone()
            );

            statement.setString(
                    8,
                    order.getShippingAddress()
            );

            statement.setString(
                    9,
                    order.getShippingCity()
            );

            statement.setString(
                    10,
                    order.getShippingState()
            );

            statement.setString(
                    11,
                    order.getShippingPincode()
            );


            int rowsAffected =
                    statement.executeUpdate();


            if (rowsAffected > 0) {

                try (
                    ResultSet generatedKeys =
                            statement.getGeneratedKeys()
                ) {

                    if (generatedKeys.next()) {

                        int orderId =
                                generatedKeys.getInt(1);

                        order.setOrderId(
                                orderId
                        );

                        return orderId;
                    }
                }
            }

        } catch (Exception e) {

            e.printStackTrace();
        }

        return -1;
    }


    // =========================================================
    // 2. GET ORDER BY ID
    // =========================================================

    @Override
    public Order getOrderById(
            int orderId) {

        String sql =
                "SELECT * FROM orders "
              + "WHERE order_id = ?";

        try (
            Connection connection =
                    DBConnection.getConnection();

            PreparedStatement statement =
                    connection.prepareStatement(sql)
        ) {

            statement.setInt(
                    1,
                    orderId
            );

            try (
                ResultSet resultSet =
                        statement.executeQuery()
            ) {

                if (resultSet.next()) {

                    return mapOrder(
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
    // 3. GET ALL ORDERS
    // =========================================================

    @Override
    public List<Order> getAllOrders() {

        List<Order> orders =
                new ArrayList<>();

        String sql =
                "SELECT * FROM orders "
              + "ORDER BY order_date DESC";

        try (
            Connection connection =
                    DBConnection.getConnection();

            PreparedStatement statement =
                    connection.prepareStatement(sql);

            ResultSet resultSet =
                    statement.executeQuery()
        ) {

            while (resultSet.next()) {

                orders.add(
                        mapOrder(resultSet)
                );
            }

        } catch (Exception e) {

            e.printStackTrace();
        }

        return orders;
    }


    // =========================================================
    // 4. GET ORDERS BY USER ID
    // =========================================================

    @Override
    public List<Order> getOrdersByUserId(
            int userId) {

        List<Order> orders =
                new ArrayList<>();

        String sql =
                "SELECT * FROM orders "
              + "WHERE user_id = ? "
              + "ORDER BY order_date DESC";

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

                while (resultSet.next()) {

                    orders.add(
                            mapOrder(resultSet)
                    );
                }
            }

        } catch (Exception e) {

            e.printStackTrace();
        }

        return orders;
    }


    // =========================================================
    // 5. GET ORDERS BY STATUS
    // =========================================================

    @Override
    public List<Order> getOrdersByStatus(
            String orderStatus) {

        List<Order> orders =
                new ArrayList<>();

        String sql =
                "SELECT * FROM orders "
              + "WHERE order_status = ? "
              + "ORDER BY order_date DESC";

        try (
            Connection connection =
                    DBConnection.getConnection();

            PreparedStatement statement =
                    connection.prepareStatement(sql)
        ) {

            statement.setString(
                    1,
                    orderStatus
            );

            try (
                ResultSet resultSet =
                        statement.executeQuery()
            ) {

                while (resultSet.next()) {

                    orders.add(
                            mapOrder(resultSet)
                    );
                }
            }

        } catch (Exception e) {

            e.printStackTrace();
        }

        return orders;
    }


    // =========================================================
    // 6. GET ORDERS BY PAYMENT STATUS
    // =========================================================

    @Override
    public List<Order> getOrdersByPaymentStatus(
            String paymentStatus) {

        List<Order> orders =
                new ArrayList<>();

        String sql =
                "SELECT * FROM orders "
              + "WHERE payment_status = ? "
              + "ORDER BY order_date DESC";

        try (
            Connection connection =
                    DBConnection.getConnection();

            PreparedStatement statement =
                    connection.prepareStatement(sql)
        ) {

            statement.setString(
                    1,
                    paymentStatus
            );

            try (
                ResultSet resultSet =
                        statement.executeQuery()
            ) {

                while (resultSet.next()) {

                    orders.add(
                            mapOrder(resultSet)
                    );
                }
            }

        } catch (Exception e) {

            e.printStackTrace();
        }

        return orders;
    }


    // =========================================================
    // 7. GET ORDERS BY PAYMENT METHOD
    // =========================================================

    @Override
    public List<Order> getOrdersByPaymentMethod(
            String paymentMethod) {

        List<Order> orders =
                new ArrayList<>();

        String sql =
                "SELECT * FROM orders "
              + "WHERE payment_method = ? "
              + "ORDER BY order_date DESC";

        try (
            Connection connection =
                    DBConnection.getConnection();

            PreparedStatement statement =
                    connection.prepareStatement(sql)
        ) {

            statement.setString(
                    1,
                    paymentMethod
            );

            try (
                ResultSet resultSet =
                        statement.executeQuery()
            ) {

                while (resultSet.next()) {

                    orders.add(
                            mapOrder(resultSet)
                    );
                }
            }

        } catch (Exception e) {

            e.printStackTrace();
        }

        return orders;
    }


    // =========================================================
    // 8. GET ORDERS BY USER AND STATUS
    // =========================================================

    @Override
    public List<Order> getOrdersByUserAndStatus(
            int userId,
            String orderStatus) {

        List<Order> orders =
                new ArrayList<>();

        String sql =
                "SELECT * FROM orders "
              + "WHERE user_id = ? "
              + "AND order_status = ? "
              + "ORDER BY order_date DESC";

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

            statement.setString(
                    2,
                    orderStatus
            );

            try (
                ResultSet resultSet =
                        statement.executeQuery()
            ) {

                while (resultSet.next()) {

                    orders.add(
                            mapOrder(resultSet)
                    );
                }
            }

        } catch (Exception e) {

            e.printStackTrace();
        }

        return orders;
    }


    // =========================================================
    // 9. GET ORDERS BY DATE RANGE
    // =========================================================

    @Override
    public List<Order> getOrdersByDateRange(
            Timestamp startDate,
            Timestamp endDate) {

        List<Order> orders =
                new ArrayList<>();

        String sql =
                "SELECT * FROM orders "
              + "WHERE order_date BETWEEN ? AND ? "
              + "ORDER BY order_date DESC";

        try (
            Connection connection =
                    DBConnection.getConnection();

            PreparedStatement statement =
                    connection.prepareStatement(sql)
        ) {

            statement.setTimestamp(
                    1,
                    startDate
            );

            statement.setTimestamp(
                    2,
                    endDate
            );

            try (
                ResultSet resultSet =
                        statement.executeQuery()
            ) {

                while (resultSet.next()) {

                    orders.add(
                            mapOrder(resultSet)
                    );
                }
            }

        } catch (Exception e) {

            e.printStackTrace();
        }

        return orders;
    }


    // =========================================================
    // 10. UPDATE ORDER
    // =========================================================

    @Override
    public boolean updateOrder(
            Order order) {

        String sql =
                "UPDATE orders SET "
              + "total_amount = ?, "
              + "payment_method = ?, "
              + "payment_status = ?, "
              + "order_status = ?, "
              + "shipping_name = ?, "
              + "shipping_phone = ?, "
              + "shipping_address = ?, "
              + "shipping_city = ?, "
              + "shipping_state = ?, "
              + "shipping_pincode = ? "
              + "WHERE order_id = ?";

        try (
            Connection connection =
                    DBConnection.getConnection();

            PreparedStatement statement =
                    connection.prepareStatement(sql)
        ) {

            statement.setDouble(
                    1,
                    order.getTotalAmount()
            );

            statement.setString(
                    2,
                    order.getPaymentMethod()
            );

            statement.setString(
                    3,
                    order.getPaymentStatus()
            );

            statement.setString(
                    4,
                    order.getOrderStatus()
            );

            statement.setString(
                    5,
                    order.getShippingName()
            );

            statement.setString(
                    6,
                    order.getShippingPhone()
            );

            statement.setString(
                    7,
                    order.getShippingAddress()
            );

            statement.setString(
                    8,
                    order.getShippingCity()
            );

            statement.setString(
                    9,
                    order.getShippingState()
            );

            statement.setString(
                    10,
                    order.getShippingPincode()
            );

            statement.setInt(
                    11,
                    order.getOrderId()
            );

            return statement.executeUpdate() > 0;

        } catch (Exception e) {

            e.printStackTrace();
        }

        return false;
    }


    // =========================================================
    // 11. UPDATE ORDER STATUS
    // =========================================================

    @Override
    public boolean updateOrderStatus(
            int orderId,
            String orderStatus) {

        String sql =
                "UPDATE orders SET "
              + "order_status = ? "
              + "WHERE order_id = ?";

        try (
            Connection connection =
                    DBConnection.getConnection();

            PreparedStatement statement =
                    connection.prepareStatement(sql)
        ) {

            statement.setString(
                    1,
                    orderStatus
            );

            statement.setInt(
                    2,
                    orderId
            );

            return statement.executeUpdate() > 0;

        } catch (Exception e) {

            e.printStackTrace();
        }

        return false;
    }


    // =========================================================
    // 12. UPDATE PAYMENT STATUS
    // =========================================================

    @Override
    public boolean updatePaymentStatus(
            int orderId,
            String paymentStatus) {

        String sql =
                "UPDATE orders SET "
              + "payment_status = ? "
              + "WHERE order_id = ?";

        try (
            Connection connection =
                    DBConnection.getConnection();

            PreparedStatement statement =
                    connection.prepareStatement(sql)
        ) {

            statement.setString(
                    1,
                    paymentStatus
            );

            statement.setInt(
                    2,
                    orderId
            );

            return statement.executeUpdate() > 0;

        } catch (Exception e) {

            e.printStackTrace();
        }

        return false;
    }


    // =========================================================
    // 13. DELETE ORDER
    // =========================================================

    @Override
    public boolean deleteOrder(
            int orderId) {

        String sql =
                "DELETE FROM orders "
              + "WHERE order_id = ?";

        try (
            Connection connection =
                    DBConnection.getConnection();

            PreparedStatement statement =
                    connection.prepareStatement(sql)
        ) {

            statement.setInt(
                    1,
                    orderId
            );

            return statement.executeUpdate() > 0;

        } catch (Exception e) {

            e.printStackTrace();
        }

        return false;
    }


    // =========================================================
    // 14. CHECK ORDER EXISTS
    // =========================================================

    @Override
    public boolean orderExists(
            int orderId) {

        String sql =
                "SELECT 1 FROM orders "
              + "WHERE order_id = ?";

        try (
            Connection connection =
                    DBConnection.getConnection();

            PreparedStatement statement =
                    connection.prepareStatement(sql)
        ) {

            statement.setInt(
                    1,
                    orderId
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
    // 15. COUNT ORDERS BY USER
    // =========================================================

    @Override
    public int getOrderCountByUser(
            int userId) {

        String sql =
                "SELECT COUNT(*) "
              + "FROM orders "
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

                    return resultSet.getInt(1);
                }
            }

        } catch (Exception e) {

            e.printStackTrace();
        }

        return 0;
    }


    // =========================================================
    // 16. COUNT ORDERS BY STATUS
    // =========================================================

    @Override
    public int getOrderCountByStatus(
            String orderStatus) {

        String sql =
                "SELECT COUNT(*) "
              + "FROM orders "
              + "WHERE order_status = ?";

        try (
            Connection connection =
                    DBConnection.getConnection();

            PreparedStatement statement =
                    connection.prepareStatement(sql)
        ) {

            statement.setString(
                    1,
                    orderStatus
            );

            try (
                ResultSet resultSet =
                        statement.executeQuery()
            ) {

                if (resultSet.next()) {

                    return resultSet.getInt(1);
                }
            }

        } catch (Exception e) {

            e.printStackTrace();
        }

        return 0;
    }


    // =========================================================
    // RESULTSET TO ORDER OBJECT
    // =========================================================

    private Order mapOrder(
            ResultSet resultSet)
            throws Exception {

        Order order =
                new Order();

        order.setOrderId(
                resultSet.getInt(
                        "order_id"
                )
        );

        order.setUserId(
                resultSet.getInt(
                        "user_id"
                )
        );

        order.setTotalAmount(
                resultSet.getDouble(
                        "total_amount"
                )
        );

        order.setPaymentMethod(
                resultSet.getString(
                        "payment_method"
                )
        );

        order.setPaymentStatus(
                resultSet.getString(
                        "payment_status"
                )
        );

        order.setOrderStatus(
                resultSet.getString(
                        "order_status"
                )
        );

        order.setShippingName(
                resultSet.getString(
                        "shipping_name"
                )
        );

        order.setShippingPhone(
                resultSet.getString(
                        "shipping_phone"
                )
        );

        order.setShippingAddress(
                resultSet.getString(
                        "shipping_address"
                )
        );

        order.setShippingCity(
                resultSet.getString(
                        "shipping_city"
                )
        );

        order.setShippingState(
                resultSet.getString(
                        "shipping_state"
                )
        );

        order.setShippingPincode(
                resultSet.getString(
                        "shipping_pincode"
                )
        );

        order.setOrderDate(
                resultSet.getTimestamp(
                        "order_date"
                )
        );

        return order;
    }
}