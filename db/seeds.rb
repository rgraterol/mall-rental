admin_role = Role.create!(name: 'SUPER MALL ADMIN', permissions: Permission.where(name: 'manage'))

User.create!(username: 'mall_admin', password: '12345678', email: 'surf.airwaves@hotmail.com', role: admin_role)