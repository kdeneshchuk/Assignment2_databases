EXPLAIN ANALYZE 
WITH books_joined AS (
SELECT 
	pb.genre AS genre,
	pb.author AS author,
	ab.title AS title,
	CAST(REPLACE(ab.price, '₹', '') AS DECIMAL(10,2))AS price,
	ab.rating AS amazon_rating,
	pb.rating AS perfect_rating,
	pb.total_ratings AS total_ratings
	FROM perfect_books pb 
	INNER JOIN amazon_books ab 
		ON pb.title = ab.title 
		AND pb.author = ab.author
		AND ab.price IS NOT NULL 
	WHERE pb.rating >= 4.0
  	AND pb.total_ratings > 100
),
popular_stats AS (
SELECT 
	author, 
	COUNT(*) AS highly_rated_books
	FROM amazon_popular_books
	WHERE rating > 4.5
	GROUP BY author
)

SELECT 
	b.genre,
	b.author,
	COUNT(DISTINCT b.title) AS total_books_amazon,
	ROUND(AVG(b.price),2) AS avg_price_amazon,
	ROUND(AVG(b.amazon_rating),2) AS avg_rating_amazon,
	ROUND(AVG(b.perfect_rating),2) AS avg_rating_perfect,
	MAX(COALESCE(ps.highly_rated_books, 0)) AS highly_rated_popular_books,
	RANK() OVER (PARTITION BY b.genre ORDER BY AVG(b.total_ratings) DESC) AS author_rank_in_genre
FROM books_joined b
LEFT JOIN popular_stats ps 
	ON ps.author = b.author
GROUP BY b.author, b.genre
HAVING COUNT(DISTINCT b.title) >= 2
ORDER BY avg_rating_amazon DESC
LIMIT 50;