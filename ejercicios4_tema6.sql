use empresaclase;

-- 1
delimiter $$
drop procedure if exists empleados3Hijos $$
create procedure empleadosHijos (
	numHijos tinyint )
begin 
	select * 
    from empleados
    where empleados.numhiem = numHijos;
end $$
delimiter ;