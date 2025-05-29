CREATE INDEX idx_perfect_rating ON perfect_books(rating);
CREATE INDEX idx_perfect_total_rating ON perfect_books(total_ratings);
CREATE INDEX idx_perfect_author_genre ON perfect_books(author, genre);

CREATE INDEX idx_amazon_books_title_author ON amazon_books(title(100), author(100));

CREATE INDEX idx_popular_authot_rating ON amazon_popular_books(author, rating);
