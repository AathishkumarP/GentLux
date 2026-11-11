package com.gentlux.util;

import java.util.regex.Pattern;
import org.mindrot.jbcrypt.BCrypt;

/**
 * Utility class for secure password hashing and verification using BCrypt.
 * Supports transparent progressive migration from legacy plaintext passwords.
 */
public final class PasswordUtil {

    /**
     * Standard BCrypt hash pattern:
     * - Starts with $2a$, $2b$, or $2y$
     * - Followed by 2-digit cost factor (e.g. 10, 12)
     * - Followed by 53 characters from BCrypt Base64 alphabet (22 salt + 31 hash)
     * - Total length: exactly 60 characters
     */
    private static final Pattern BCRYPT_PATTERN =
            Pattern.compile("^\\$2[aby]?\\$\\d{2}\\$[./A-Za-z0-9]{53}$");

    /**
     * Recommended BCrypt work factor (cost parameter).
     * 12 rounds provides a strong balance between security and server throughput.
     */
    private static final int BCRYPT_WORK_FACTOR = 12;

    /**
     * Private constructor to prevent instantiation of utility class.
     */
    private PasswordUtil() {
        // Utility class
    }

    /**
     * Hashes a plaintext password using BCrypt with a salt work factor of 12.
     *
     * @param plainPassword the plaintext password to hash
     * @return the 60-character BCrypt hash string
     * @throws IllegalArgumentException if plainPassword is null or empty
     */
    public static String hashPassword(String plainPassword) {
        if (plainPassword == null || plainPassword.isEmpty()) {
            throw new IllegalArgumentException("Password cannot be null or empty.");
        }
        return BCrypt.hashpw(plainPassword, BCrypt.gensalt(BCRYPT_WORK_FACTOR));
    }

    /**
     * Verifies a candidate plaintext password against a stored password.
     * Supports both modern BCrypt hashes and legacy plaintext passwords.
     *
     * @param plainPassword the plaintext password entered by the user
     * @param storedPassword the password or hash stored in the database
     * @return true if the password matches, false otherwise
     */
    public static boolean checkPassword(String plainPassword, String storedPassword) {
        if (plainPassword == null || plainPassword.isEmpty()
                || storedPassword == null || storedPassword.isEmpty()) {
            return false;
        }

        if (isBCryptHash(storedPassword)) {
            try {
                return BCrypt.checkpw(plainPassword, storedPassword);
            } catch (IllegalArgumentException e) {
                return false;
            }
        }

        // Fallback for legacy plaintext passwords
        return plainPassword.equals(storedPassword);
    }

    /**
     * Checks whether a stored password string matches the BCrypt hash format.
     *
     * @param storedPassword the stored password string to inspect
     * @return true if storedPassword is a valid 60-character BCrypt hash, false otherwise
     */
    public static boolean isBCryptHash(String storedPassword) {
        if (storedPassword == null || storedPassword.length() != 60) {
            return false;
        }
        return BCRYPT_PATTERN.matcher(storedPassword).matches();
    }
}
