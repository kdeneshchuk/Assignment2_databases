Assignment 2 - Query Optimizaton by Deneshchuk Khrystyna

Структура проєкту:
Assignment2_databases/
├── README.md
├── query_versions/
│ ├── original_query.sql
│ ├── step1_refactor.sql
│ ├── step2_indexing.sql
│ ├── step3_join.sql
│ └── step4_hints.sql
├── execution_plans/
│ └── Execution_plans.docx
├── explanations/
│ └── Optimazation explanations.docx

В цьому проєкті була зроблена покрокова оптимізація складного запиту. Початковий запит був неоптимізований та завантажувся декілька хвилин.
На кожному етапі були виконані покращення, які підвищили ефективність та читабельність коду

1 Крок  - Рефакторинг використовуючи СTE
 
Підзапит було винесено у окрему тимчасову таблицю "popular_stats".
Фільтрацію та об'єднання було винесено у "books_joined".
Основний SELECT став читабельним.
Час виконання оригінального запиту - 89139мс. Після цієї оптимізації - 319мс.
У оригінальному запиті було викликано підзапит 10950 разів. Після створення CTE - 1 раз.

2 Крок - Індексація

Створено індекси:
  - idx_perfect_rating
  - idx_perfect_total_rating
  - idx_perfect_author_genre
  - idx_amazon_books_title_author
  - idx_popular_author_rating
Кожен індекс відповідає або фільтрації, або групуванню, або джойну.

3 Крок -  Заміна JOIN

LEFT JOIN було змінено на INNER JOIN, завдяки чому була підвищена ефективність об'єднання.

4 Крок - Використання хінтів

Застосовано FORCE INDEX, USE INDEX, STRAIGHT_JOIN
  - Контроль вибору індексів вручну.
  - Явне визначення порядку з'єднання таблиць.
Запит виконується в заданих межах, що забезпечує стабільну продуктивність.