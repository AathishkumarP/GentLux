package com.gentlux.dao.impl;

import com.gentlux.dao.OrderItemDAO;
import com.gentlux.model.OrderItemView;
import com.gentlux.model.OrderItem;
import com.gentlux.util.DBConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class OrderItemDAOImpl implements OrderItemDAO {

    // =========================================================
    // 1. ADD ORDER ITEM
    // =========================================================

    @Override
    public boolean addOrderItem(OrderItem orderItem) {

        String sql = "INSERT INTO order_items "
                   + "(order_id, variant_id, quantity, price) "
                   + "VALUES (?, ?, ?, ?)";

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql)) {

            statement.setInt(1, orderItem.getOrderId());
            statement.setInt(2, orderItem.getVariantId());
            statement.setInt(3, orderItem.getQuantity());
            statement.setDouble(4, orderItem.getPrice());

            return statement.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
        }

        return false;
    }


    // =========================================================
    // 2. GET ORDER ITEM BY ID
    // =========================================================

    @Override
    public OrderItem getOrderItemById(int orderItemId) {

        String sql = "SELECT * FROM order_items "
                   + "WHERE order_item_id = ?";

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql)) {

            statement.setInt(1, orderItemId);

            try (ResultSet resultSet = statement.executeQuery()) {

                if (resultSet.next()) {
                    return mapOrderItem(resultSet);
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return null;
    }


    // =========================================================
    // 3. GET ORDER ITEMS BY ORDER ID
    // =========================================================

    @Override
    public List<OrderItem> getOrderItemsByOrderId(int orderId) {

        List<OrderItem> orderItems = new ArrayList<>();

        String sql = "SELECT * FROM order_items "
                   + "WHERE order_id = ? "
                   + "ORDER BY order_item_id ASC";

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql)) {

            statement.setInt(1, orderId);

            try (ResultSet resultSet = statement.executeQuery()) {

                while (resultSet.next()) {
                    orderItems.add(mapOrderItem(resultSet));
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return orderItems;
    }
    
 // =========================================================
 // GET ORDER ITEM VIEWS BY ORDER ID
 // =========================================================

 @Override
 public List<OrderItemView> getOrderItemViewsByOrderId(
         int orderId) {

     List<OrderItemView> orderItems =
             new ArrayList<>();


     String sql =
             "SELECT "
           + "oi.order_item_id, "
           + "oi.order_id, "
           + "oi.variant_id, "
           + "oi.quantity, "
           + "oi.price, "
           + "pv.product_id, "
           + "pv.size, "
           + "p.product_name, "
           + "p.brand, "
           + "p.image_url "
           + "FROM order_items oi "
           + "INNER JOIN product_variants pv "
           + "ON oi.variant_id = pv.variant_id "
           + "INNER JOIN products p "
           + "ON pv.product_id = p.product_id "
           + "WHERE oi.order_id = ? "
           + "ORDER BY oi.order_item_id ASC";


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

             while (resultSet.next()) {

                 OrderItemView item =
                         new OrderItemView();


                 item.setOrderItemId(
                         resultSet.getInt(
                                 "order_item_id"
                         )
                 );


                 item.setOrderId(
                         resultSet.getInt(
                                 "order_id"
                         )
                 );


                 item.setVariantId(
                         resultSet.getInt(
                                 "variant_id"
                         )
                 );


                 item.setQuantity(
                         resultSet.getInt(
                                 "quantity"
                         )
                 );


                 item.setPrice(
                         resultSet.getDouble(
                                 "price"
                         )
                 );


                 item.setProductId(
                         resultSet.getInt(
                                 "product_id"
                         )
                 );


                 item.setSize(
                         resultSet.getString(
                                 "size"
                         )
                 );


                 item.setProductName(
                         resultSet.getString(
                                 "product_name"
                         )
                 );


                 item.setBrand(
                         resultSet.getString(
                                 "brand"
                         )
                 );


                 item.setImageUrl(
                         resultSet.getString(
                                 "image_url"
                         )
                 );


                 orderItems.add(
                         item
                 );
             }
         }

     } catch (Exception e) {

         e.printStackTrace();
     }


     return orderItems;
 }


    // =========================================================
    // 4. GET ORDER ITEM BY ORDER AND VARIANT
    // =========================================================

    @Override
    public OrderItem getOrderItemByOrderAndVariant(
            int orderId,
            int variantId) {

        String sql = "SELECT * FROM order_items "
                   + "WHERE order_id = ? AND variant_id = ?";

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql)) {

            statement.setInt(1, orderId);
            statement.setInt(2, variantId);

            try (ResultSet resultSet = statement.executeQuery()) {

                if (resultSet.next()) {
                    return mapOrderItem(resultSet);
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return null;
    }


    // =========================================================
    // 5. UPDATE QUANTITY
    // =========================================================

    @Override
    public boolean updateQuantity(
            int orderItemId,
            int quantity) {

        String sql = "UPDATE order_items "
                   + "SET quantity = ? "
                   + "WHERE order_item_id = ?";

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql)) {

            statement.setInt(1, quantity);
            statement.setInt(2, orderItemId);

            return statement.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
        }

        return false;
    }


    // =========================================================
    // 6. UPDATE PRICE
    // =========================================================

    @Override
    public boolean updatePrice(
            int orderItemId,
            double price) {

        String sql = "UPDATE order_items "
                   + "SET price = ? "
                   + "WHERE order_item_id = ?";

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql)) {

            statement.setDouble(1, price);
            statement.setInt(2, orderItemId);

            return statement.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
        }

        return false;
    }


    // =========================================================
    // 7. UPDATE COMPLETE ORDER ITEM
    // =========================================================

    @Override
    public boolean updateOrderItem(OrderItem orderItem) {

        String sql = "UPDATE order_items SET "
                   + "order_id = ?, "
                   + "variant_id = ?, "
                   + "quantity = ?, "
                   + "price = ? "
                   + "WHERE order_item_id = ?";

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql)) {

            statement.setInt(1, orderItem.getOrderId());
            statement.setInt(2, orderItem.getVariantId());
            statement.setInt(3, orderItem.getQuantity());
            statement.setDouble(4, orderItem.getPrice());
            statement.setInt(5, orderItem.getOrderItemId());

            return statement.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
        }

        return false;
    }


    // =========================================================
    // 8. REMOVE ORDER ITEM
    // =========================================================

    @Override
    public boolean removeOrderItem(int orderItemId) {

        String sql = "DELETE FROM order_items "
                   + "WHERE order_item_id = ?";

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql)) {

            statement.setInt(1, orderItemId);

            return statement.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
        }

        return false;
    }


    // =========================================================
    // 9. CLEAR ALL ITEMS FROM ORDER
    // =========================================================

    @Override
    public boolean clearOrderItems(int orderId) {

        String sql = "DELETE FROM order_items "
                   + "WHERE order_id = ?";

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql)) {

            statement.setInt(1, orderId);

            return statement.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
        }

        return false;
    }


    // =========================================================
    // 10. CHECK VARIANT IN ORDER
    // =========================================================

    @Override
    public boolean isVariantInOrder(
            int orderId,
            int variantId) {

        String sql = "SELECT 1 FROM order_items "
                   + "WHERE order_id = ? AND variant_id = ?";

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql)) {

            statement.setInt(1, orderId);
            statement.setInt(2, variantId);

            try (ResultSet resultSet = statement.executeQuery()) {

                return resultSet.next();
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return false;
    }


    // =========================================================
    // 11. GET ORDER ITEM COUNT
    // =========================================================

    @Override
    public int getOrderItemCount(int orderId) {

        String sql = "SELECT COUNT(*) "
                   + "FROM order_items "
                   + "WHERE order_id = ?";

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql)) {

            statement.setInt(1, orderId);

            try (ResultSet resultSet = statement.executeQuery()) {

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
    // 12. GET TOTAL QUANTITY
    // =========================================================

    @Override
    public int getTotalQuantity(int orderId) {

        String sql = "SELECT COALESCE(SUM(quantity), 0) "
                   + "FROM order_items "
                   + "WHERE order_id = ?";

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql)) {

            statement.setInt(1, orderId);

            try (ResultSet resultSet = statement.executeQuery()) {

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
    // 13. GET ORDER TOTAL
    // =========================================================

    @Override
    public double getOrderTotal(int orderId) {

        String sql = "SELECT COALESCE(SUM(quantity * price), 0) "
                   + "FROM order_items "
                   + "WHERE order_id = ?";

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql)) {

            statement.setInt(1, orderId);

            try (ResultSet resultSet = statement.executeQuery()) {

                if (resultSet.next()) {
                    return resultSet.getDouble(1);
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return 0.0;
    }


    // =========================================================
    // RESULTSET → ORDER ITEM OBJECT
    // =========================================================

    private OrderItem mapOrderItem(ResultSet resultSet)
            throws Exception {

        OrderItem orderItem = new OrderItem();

        orderItem.setOrderItemId(
                resultSet.getInt("order_item_id")
        );

        orderItem.setOrderId(
                resultSet.getInt("order_id")
        );

        orderItem.setVariantId(
                resultSet.getInt("variant_id")
        );

        orderItem.setQuantity(
                resultSet.getInt("quantity")
        );

        orderItem.setPrice(
                resultSet.getDouble("price")
        );

        return orderItem;
    }
}