-- Part One Create a Trigger
-- Emma Bea Mitchell

CREATE TRIGGER egg_filler
    AFTER INSERT ON Bird_eggs
    FOR EACH ROW
    BEGIN
        UPDATE ...;
    END;