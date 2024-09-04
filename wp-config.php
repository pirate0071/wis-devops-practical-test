<?php
/**
 * The base configuration for WordPress
 *
 * The wp-config.php creation script uses this file during the installation.
 * You don't have to use the web site, you can copy this file to "wp-config.php"
 * and fill in the values.
 *
 * This file contains the following configurations:
 *
 * * Database settings
 * * Secret keys
 * * Database table prefix
 * * Localized language
 * * ABSPATH
 *
 * @link https://wordpress.org/support/article/editing-wp-config-php/
 *
 * @package WordPress
 */

// ** Database settings - You can get this info from your web host ** //
/** The name of the database for WordPress */
define( 'DB_NAME', 'DB_NAME_VALUE' );

/** Database username */
define( 'DB_USER', 'DB_USER_VALUE' );

/** Database password */
define( 'DB_PASSWORD', 'DB_PASSWORD_VALUE' );

/** Database hostname */
define( 'DB_HOST', 'localhost' );

/** Database charset to use in creating database tables. */
define( 'DB_CHARSET', 'utf8' );

/** The database collate type. Don't change this if in doubt. */
define( 'DB_COLLATE', '' );

/**#@+
 * Authentication unique keys and salts.
 *
 * Change these to different unique phrases! You can generate these using
 * the {@link https://api.wordpress.org/secret-key/1.1/salt/ WordPress.org secret-key service}.
 *
 * You can change these at any point in time to invalidate all existing cookies.
 * This will force all users to have to log in again.
 *
 * @since 2.6.0
 */
define( 'AUTH_KEY',          '$^OuVg*12_71,]1H~Z$$hlQY(:|?]BE 5bg9uf)WYtw|fm^l.Bz(G^r^YAP~MAgb' );
define( 'SECURE_AUTH_KEY',   '!Km~m90~{XrBFB63wVqXp1c7S>$bQ.+_:X M_1Cdo{b<c|wP?2h RR@<<<`e.]dB' );
define( 'LOGGED_IN_KEY',     'cV-4Hn>eD7r8f/Nnp^?8DH {)r[C!fl.@nE3:B$qiX>6UZ?*loSBb.>8^0[?zIIC' );
define( 'NONCE_KEY',         'v4$x<)$q-1R/yNh_%%2#w<!2Wys*Z3x}iJ$b2Qv1o.Ff@ Fj+I3LuOMR?%nvOZP.' );
define( 'AUTH_SALT',         'hGq=315[rK?%3P3j~#gb?V30nr7/d)(O1}}h|0MT2jl@;_gMMw%mumXU:76wk;Pa' );
define( 'SECURE_AUTH_SALT',  'xLBrH>xsk  j.8ORiId_J*k@Ib V*y$TOc;mQ}zt|PCJ@gS#lt{(EDmyX/1C}V,]' );
define( 'LOGGED_IN_SALT',    'yxs!{o-rf+#/^)iZY#5x(|><2XHhR{l4#YE||s6-f?n+c_L- s-2OCB]$4)1%YR{' );
define( 'NONCE_SALT',        'aM.Q8K<@;DN+m.zIO*)hY!VBmOijKAW~vpHEGQ}T5F@UMSoOXT0hFBWf-?B[h)&i' );
define( 'WP_CACHE_KEY_SALT', '-($RMgYio}`gCb}nqzTfCcQkOE(JA-Q{rzZIN5#K?GnFYxPNT~qsdB}5.M:^ce3<' );


/**#@-*/

/**
 * WordPress database table prefix.
 *
 * You can have multiple installations in one database if you give each
 * a unique prefix. Only numbers, letters, and underscores please!
 */
$table_prefix = 'wp_';


/* Add any custom values between this line and the "stop editing" line. */



/**
 * For developers: WordPress debugging mode.
 *
 * Change this to true to enable the display of notices during development.
 * It is strongly recommended that plugin and theme developers use WP_DEBUG
 * in their development environments.
 *
 * For information on other constants that can be used for debugging,
 * visit the documentation.
 *
 * @link https://wordpress.org/support/article/debugging-in-wordpress/
 */
if ( ! defined( 'WP_DEBUG' ) ) {
	define( 'WP_DEBUG', false );
}

/* That's all, stop editing! Happy publishing. */

/** Absolute path to the WordPress directory. */
if ( ! defined( 'ABSPATH' ) ) {
	define( 'ABSPATH', __DIR__ . '/' );
}

/** Sets up WordPress vars and included files. */
require_once ABSPATH . 'wp-settings.php';
