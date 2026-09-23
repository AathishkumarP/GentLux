package com.gentlux.dao;

import java.util.List;

import com.gentlux.model.OrderItem;
import com.gentlux.model.OrderItemView;

public interface OrderItemDAO {

    // =========================================================
    // CREATE
    // =========================================================

    boolean addOrderItem(OrderItem orderItem);


 // =========================================================
 // READ / FETCH
 // =========================================================

 OrderItem getOrderItemById(int orderItemId);

 List<OrderItem> getOrderItemsByOrderId(int orderId);

 List<OrderItemView> getOrderItemViewsByOrderId(int orderId);

 OrderItem getOrderItemByOrderAndVariant(
         int orderId,
         int variantId
 );


    // =========================================================
    // UPDATE
    // =========================================================

    boolean updateQuantity(
            int orderItemId,
            int quantity
    );

    boolean updatePrice(
            int orderItemId,
            double price
    );

    boolean updateOrderItem(OrderItem orderItem);


    // =========================================================
    // DELETE
    // =========================================================

    boolean removeOrderItem(int orderItemId);

    boolean clearOrderItems(int orderId);


    // =========================================================
    // CHECK
    // =========================================================

    boolean isVariantInOrder(
            int orderId,
            int variantId
    );


    // =========================================================
    // COUNT / TOTAL
    // =========================================================

    int getOrderItemCount(int orderId);

    int getTotalQuantity(int orderId);

    double getOrderTotal(int orderId);
}