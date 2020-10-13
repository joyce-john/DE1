USE classicmodels;

-- Exercise 1
DROP PROCEDURE IF EXISTS GetPayments;

DELIMITER //

CREATE PROCEDURE GetPayments(
				IN rownumbers INT)
BEGIN
	SELECT *
		FROM payments
			LIMIT rownumbers ;
END //
DELIMITER ;

CALL GetPayments(3)

-- Exercise 2
DROP PROCEDURE IF EXISTS GetAmount;

DELIMITER //

CREATE PROCEDURE GetAmount(
						IN entry INT,
                        OUT val DECIMAL(10,2)
                        )
BEGIN
DECLARE x INT;
SET x = (entry - 1) ;
SELECT amount 
	INTO val
		FROM payments 
			LIMIT x,1 ;
END //
DELIMITER ;

CALL GetAmount(35, @val);
SELECT @val;

-- Exercise 3: for some reason, the // delimiter wasn't working, so I had to switch to $$

DROP PROCEDURE IF EXISTS GetCategory;

DELIMITER $$

CREATE PROCEDURE GetCategory(
	IN entry INT,
	OUT category VARCHAR(25)
	)

BEGIN
	DECLARE x INT;
	DECLARE y FLOAT;
	SET x = (entry - 1);

	SELECT amount
		INTO y
			FROM payments
				LIMIT x, 1;
            
	IF y <= 10000
		THEN SET category = "CAT3";
	ELSEIF y > 10000 & y < 100000
		THEN SET category = "CAT2";
	ELSE
		SET category = "CAT1";

	END IF;
    
END $$
DELIMITER ;

CALL GetCategory(18, @category);
Select @category;



