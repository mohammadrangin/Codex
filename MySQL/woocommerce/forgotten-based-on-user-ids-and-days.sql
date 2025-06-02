SELECT 
    users.ID AS user_id, 
    users.user_login AS phone, 
    users.display_name AS full_name, 
    users.user_registered AS registered_at,
    MAX(posts.post_modified) AS last_order_date,
    DATEDIFF(CURRENT_DATE(), MAX(posts.post_modified)) AS forgotten_days
FROM wp_sdusers AS users 
INNER JOIN wp_sdpostmeta AS postmeta 
    ON postmeta.meta_key = '_customer_user' 
    AND postmeta.meta_value = users.ID 
INNER JOIN wp_sdposts AS posts 
    ON posts.ID = postmeta.post_id 
    AND posts.post_type = 'shop_order' 
    AND posts.post_status = 'wc-completed' 
WHERE users.ID IN (
    -- Your long list of IDs here
    -- (I've omitted it for brevity, but keep your full list)
)
GROUP BY users.ID, users.user_login, users.display_name, users.user_registered
ORDER BY forgotten_days DESC;
