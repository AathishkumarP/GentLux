package com.gentlux.dao;

import com.gentlux.model.Order;

import java.sql.Timestamp;
import java.util.List;

public interface OrderDAO {

    // =========================================================
    // CREATE ORDER
    // =========================================================

    boolean createOrder(Order order);


    // =========================================================
    // READ / FETCH ORDERS
    // =========================================================

    Order getOrderById(int orderId);

    List<Order> getAllOrders();

    List<Order> getOrdersByUserId(int userId);


    // =========================================================
    // SEARCH / FILTER ORDERS
    // =========================================================

    List<Order> getOrdersByStatus(String orderStatus);

    List<Order> getOrdersByPaymentStatus(String paymentStatus);

    List<Order> getOrdersByPaymentMethod(String paymentMethod);

    List<Order> getOrdersByUserAndStatus(
            int userId,
            String orderStatus
    );

    List<Order> getOrdersByDateRange(
            Timestamp startDate,
            Timestamp endDate
    );


    // =========================================================
    // UPDATE ORDER
    // =========================================================

    boolean updateOrder(Order order);

    boolean updateOrderStatus(
            int orderId,
            String orderStatus
    );

    boolean updatePaymentStatus(
            int orderId,
            String paymentStatus
    );


    // =========================================================
    // DELETE ORDER
    // =========================================================

    boolean deleteOrder(int orderId);


    // =========================================================
    // CHECK ORDER
    // =========================================================

    boolean orderExists(int orderId);


    // =========================================================
    // COUNT ORDERS
    // =========================================================

    int getOrderCountByUser(int userId);

    int getOrderCountByStatus(String orderStatus);
}