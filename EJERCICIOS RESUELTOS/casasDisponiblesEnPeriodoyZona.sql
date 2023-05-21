drop procedure if not exists casasDisponiblesEnPeriodoyZona;
delimiter $$
CREATE PROCEDURE casasDisponiblesEnPeriodoyZona(in fechaini date, in fechafin date, in zona int)
begin
	-- call casasDisponiblesEnPeriodoyZona('2013/3/15','2013/3/18',1) -- están disponibles las casas Jazmín y Azucena
    -- call casasDisponiblesEnPeriodoyZona('2013/3/15','2013/3/20',1) -- está disponible la casa Jazmín
    -- call casasDisponiblesEnPeriodoyZona('2013/3/21','2013/3/30',1) -- está disponible la casa Jazmín
    -- call casasDisponiblesEnPeriodoyZona('2013/3/25','2013/3/30',1) -- están disponibles las casas Jazmín y Azucena

	select codcasa, nomcasa
	from casas
	where codzona=zona and
		codcasa not in (select codcasa
						from reservas
						where fecanulacion is null and
							(feciniestancia between fechaini and fechafin
								or fechaini between feciniestancia and date_add(feciniestancia, interval numdiasestancia day)
                            )
						);

end $$
delimiter ;