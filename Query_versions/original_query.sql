DROP DATABASE assignment_2;
CREATE DATABASE assignment_2;
USE assignment_2;

EXPLAIN ANALYZE 
SELECT
    pb.genre,
    pb.author,
    COUNT(DISTINCT ab.title) AS total_books_amazon,
    ROUND(AVG(CAST(REPLACE(ab.price, '₹', '') AS DECIMAL(10,2))), 2) AS avg_price_amazon,
    AVG(ab.rating) AS avg_rating_amazon,
    AVG(pb.rating) AS avg_rating_perfect,
    (
        SELECT COUNT(*) 
        FROM amazon_popular_books apb 
        WHERE apb.author = pb.author AND apb.rating > 4.5
    ) AS highly_rated_popular_books,
    RANK() OVER (PARTITION BY pb.genre ORDER BY AVG(pb.total_ratings) DESC) AS author_rank_in_genre
FROM perfect_books pb
LEFT JOIN amazon_books ab ON pb.title = ab.title AND pb.author = ab.author
WHERE pb.rating >= 4.0
  AND pb.total_ratings > 100
  AND ab.price IS NOT NULL
GROUP BY pb.genre, pb.author
HAVING COUNT(DISTINCT ab.title) >= 2
ORDER BY avg_rating_amazon DESC
LIMIT 50;
