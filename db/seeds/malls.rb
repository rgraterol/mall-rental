bs = Moneda.create!(nombre: 'Bolívares')
dolar = Moneda.create!(nombre: 'Dolares')
euro = Moneda.create!(nombre: 'Euros')

venezuela = Pai.create!(nombre: 'Venezuela', moneda: bs)
usa = Pai.create!(nombre: 'Estados Unidos', moneda: dolar)
españa = Pai.create!(nombre: 'España', moneda: euro)

cc_vela = Mall.create!(nombre: 'C.C La Vela', abreviado: 'cc_vela', rif: 'V-98735638-1', direccion_fiscal: 'Porlamar - Margarita', telefono: '0285-8965425', pai: venezuela)
