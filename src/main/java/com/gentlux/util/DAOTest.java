package com.gentlux.util;

import com.gentlux.dao.OrderDAO;
import com.gentlux.dao.impl.OrderDAOImpl;
import com.gentlux.model.Order;

import java.util.List;

public class DAOTest {

    public static void main(String[] args) {

        System.out.println("=================================");
        System.out.println("       GENTLUX DAO TEST");
        System.out.println("=================================");

        testOrderDAO();
    }

    private static void testOrderDAO() {

        OrderDAO orderDAO = new OrderDAOImpl();

        // =====================================================
        // 1. GET ALL ORDERS
        // =====================================================

        System.out.println("\n1. GET ALL ORDERS");

        List<Order> orders = orderDAO.getAllOrders();

        if (orders.isEmpty()) {
            System.out.println("No orders found");
        } else {

            for (Order order : orders) {

                System.out.println(
                    "Order ID: " + order.getOrderId()
                    + " | User ID: " + order.getUserId()
                    + " | Total: ₹" + order.getTotalAmount()
                    + " | Payment: " + order.getPaymentMethod()
                    + " | Payment Status: " + order.getPaymentStatus()
                    + " | Order Status: " + order.getOrderStatus()
                );
            }
        }


        // =====================================================
        // 2. GET ORDER BY ID
        // =====================================================

        System.out.println("\n2. GET ORDER BY ID");

        int orderId = 1;

        Order order = orderDAO.getOrderById(orderId);

        if (order != null) {

            System.out.println(
                "Order ID: " + order.getOrderId()
                + " | User ID: " + order.getUserId()
                + " | Total: ₹" + order.getTotalAmount()
                + " | Payment Method: " + order.getPaymentMethod()
                + " | Payment Status: " + order.getPaymentStatus()
                + " | Order Status: " + order.getOrderStatus()
            );

        } else {

            System.out.println("Order not found");
        }


        // =====================================================
        // 3. GET ORDERS BY USER ID
        // =====================================================

        System.out.println("\n3. GET ORDERS BY USER ID");

        int userId = 1;

        List<Order> userOrders =
                orderDAO.getOrdersByUserId(userId);

        if (userOrders.isEmpty()) {

            System.out.println(
                "No orders found for User ID " + userId
            );

        } else {

            for (Order userOrder : userOrders) {

                System.out.println(
                    "Order ID: " + userOrder.getOrderId()
                    + " | Total: ₹" + userOrder.getTotalAmount()
                    + " | Status: " + userOrder.getOrderStatus()
                );
            }
        }


        // =====================================================
        // 4. GET ORDERS BY ORDER STATUS
        // =====================================================

        System.out.println("\n4. GET ORDERS BY ORDER STATUS");

        String orderStatus = "PLACED";

        List<Order> statusOrders =
                orderDAO.getOrdersByStatus(orderStatus);

        if (statusOrders.isEmpty()) {

            System.out.println(
                "No orders found with status: "
                + orderStatus
            );

        } else {

            for (Order statusOrder : statusOrders) {

                System.out.println(
                    "Order ID: " + statusOrder.getOrderId()
                    + " | User ID: " + statusOrder.getUserId()
                    + " | Total: ₹" + statusOrder.getTotalAmount()
                    + " | Status: " + statusOrder.getOrderStatus()
                );
            }
        }


        // =====================================================
        // 5. GET ORDERS BY PAYMENT STATUS
        // =====================================================

        System.out.println("\n5. GET ORDERS BY PAYMENT STATUS");

        String paymentStatus = "PAID";

        List<Order> paymentStatusOrders =
                orderDAO.getOrdersByPaymentStatus(paymentStatus);

        if (paymentStatusOrders.isEmpty()) {

            System.out.println(
                "No orders found with payment status: "
                + paymentStatus
            );

        } else {

            for (Order paymentOrder : paymentStatusOrders) {

                System.out.println(
                    "Order ID: " + paymentOrder.getOrderId()
                    + " | User ID: " + paymentOrder.getUserId()
                    + " | Total: ₹" + paymentOrder.getTotalAmount()
                    + " | Payment Status: "
                    + paymentOrder.getPaymentStatus()
                );
            }
        }


        // =====================================================
        // 6. GET ORDERS BY PAYMENT METHOD
        // =====================================================

        System.out.println("\n6. GET ORDERS BY PAYMENT METHOD");

        String paymentMethod = "COD";

        List<Order> paymentMethodOrders =
                orderDAO.getOrdersByPaymentMethod(paymentMethod);

        if (paymentMethodOrders.isEmpty()) {

            System.out.println(
                "No orders found with payment method: "
                + paymentMethod
            );

        } else {

            for (Order paymentOrder : paymentMethodOrders) {

                System.out.println(
                    "Order ID: " + paymentOrder.getOrderId()
                    + " | User ID: " + paymentOrder.getUserId()
                    + " | Total: ₹" + paymentOrder.getTotalAmount()
                    + " | Payment Method: "
                    + paymentOrder.getPaymentMethod()
                );
            }
        }


        // =====================================================
        // 7. GET ORDERS BY USER + STATUS
        // =====================================================

        System.out.println("\n7. GET ORDERS BY USER + STATUS");

        int searchUserId = 1;
        String searchStatus = "PLACED";

        List<Order> userStatusOrders =
                orderDAO.getOrdersByUserAndStatus(
                    searchUserId,
                    searchStatus
                );

        if (userStatusOrders.isEmpty()) {

            System.out.println(
                "No orders found for User ID "
                + searchUserId
                + " with status "
                + searchStatus
            );

        } else {

            for (Order userStatusOrder : userStatusOrders) {

                System.out.println(
                    "Order ID: "
                    + userStatusOrder.getOrderId()
                    + " | Total: ₹"
                    + userStatusOrder.getTotalAmount()
                    + " | Status: "
                    + userStatusOrder.getOrderStatus()
                );
            }
        }


        // =====================================================
        // 8. CHECK ORDER EXISTS
        // =====================================================

        System.out.println("\n8. CHECK ORDER EXISTS");

        int checkOrderId = 1;

        boolean exists =
                orderDAO.orderExists(checkOrderId);

        System.out.println(
            "Order " + checkOrderId
            + " exists: " + exists
        );


        // =====================================================
        // 9. COUNT ORDERS BY USER
        // =====================================================

        System.out.println("\n9. COUNT ORDERS BY USER");

        int countUserId = 1;

        int userOrderCount =
                orderDAO.getOrderCountByUser(countUserId);

        System.out.println(
            "Total orders for User ID "
            + countUserId
            + ": "
            + userOrderCount
        );


        // =====================================================
        // 10. COUNT ORDERS BY STATUS
        // =====================================================

        System.out.println("\n10. COUNT ORDERS BY STATUS");

        String countStatus = "PLACED";

        int statusCount =
                orderDAO.getOrderCountByStatus(countStatus);

        System.out.println(
            "Total orders with status "
            + countStatus
            + ": "
            + statusCount
        );


        System.out.println("\n=================================");
        System.out.println("       ORDER DAO TEST COMPLETED");
        System.out.println("=================================");
    }
}