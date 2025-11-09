/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 *
 * @author taqua
 */

import java.util.ArrayList;
import java.util.List;

public class BookingCart {
    private List<CartItem> items = new ArrayList<>();

    public void addRoom(CartItem item) {
        // Kiểm tra xem phòng đã có trong giỏ chưa
        for (CartItem existing : items) {
            if (existing.getRoom().getRoomId() == item.getRoom().getRoomId()) {
                return; // bỏ qua, không thêm trùng
            }
        }
        items.add(item);
    }

    public void removeRoom(int roomId) {
        items.removeIf(item -> item.getRoom().getRoomId() == roomId);
    }

    public void clear() {
        items.clear();
    }

    public List<CartItem> getItems() {
        return items;
    }

    public double getSubtotal() {
        double total = 0;
        for (CartItem item : items) {
            total += item.getLineTotal();
        }
        return total;
    }
}

