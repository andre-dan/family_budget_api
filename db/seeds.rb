# db/seeds.rb

puts "Limpando categorias antigas..."
Category.destroy_all

puts "Cadastrando categorias base..."

categories = [
  # Receitas
  { name: 'Salário / Renda Principal', kind: 'income', color: '#10B981' },
  { name: 'Renda Extra / Rendimentos', kind: 'income', color: '#059669' },

  # Despesas Essenciais (Inspiradas no modelo Cerbasi)
  { name: 'Habitação', kind: 'expense', color: '#EF4444' },       # Aluguel, Condomínio, Luz, Água, Gás
  { name: 'Alimentação', kind: 'expense', color: '#F59E0B' },     # Supermercado, Feira
  { name: 'Saúde & Farmácia', kind: 'expense', color: '#3B82F6' }, # Remédios, Consultas, Planos
  { name: 'Transporte', kind: 'expense', color: '#6366F1' },     # Combustível, Uber, Manutenção
  { name: 'Educação', kind: 'expense', color: '#8B5CF6' },        # Cursos, Escolas, Livros
  { name: 'Lazer & Estilo de Vida', kind: 'expense', color: '#EC4899' }, # Restaurantes, Passeios, Hobbies
  { name: 'Outros / Imprevistos', kind: 'expense', color: '#6B7280' },
  { name: 'Cabelo (Corte/Escova/Química)', kind: 'income', color: '#10B981' },
  { name: 'Unhas / Manicure', kind: 'income', color: '#059669' },
  { name: 'Estética / Sobrancelha', kind: 'income', color: '#34D399' },
  { name: 'Venda de Produtos', kind: 'income', color: '#047857' },

  # Despesas do Salão
  { name: 'Produtos & Cosméticos', kind: 'expense', color: '#EF4444' },
  { name: 'Aluguel / Contas do Salão', kind: 'expense', color: '#F59E0B' },
  { name: 'Equipamentos & Manutenção', kind: 'expense', color: '#3B82F6' },
  { name: 'Ajudantes / Comissões', kind: 'expense', color: '#EC4899' },
  { name: 'Outros / Imprevistos', kind: 'expense', color: '#6B7280' }
]

categories.each do |cat|
  Category.create!(cat)
end

puts "Categorias criadas com sucesso! Total: #{Category.count}"
