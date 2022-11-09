#language: ru
#noinspection NonAsciiCharacters
Функциональность: Процесс игры в кликер

   Предыстория: Игра запущена
    Дано Приветственный экран открыт
    Тогда Нажать на кнопку старта игры

  Структура сценария: Игры с различными результатами
    Тогда Нажать на счётчик <clicks_amount> раз
    И Убедиться, что заголовок игры "<message>"
    И Убедиться, что номер на экране - <clicks_amount>
    Тогда Подождать окончания игры
    Но Убедиться, что результат игры - <clicks_amount> кликов
    Примеры:
      | result_type | clicks_amount | message                  |
      | Low         | 10            | Faster!                  |
      | Medium      | 21            | More faster!             |
      | Good        | 51            | Good work!               |
      | Excelent    | 71            | MONSTER! ARE YOU A BOT?? |