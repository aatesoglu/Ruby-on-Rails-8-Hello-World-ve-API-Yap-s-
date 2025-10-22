# db/seeds.rb

puts "🧹 Mevcut veriler temizleniyor..."

# Önce ilişkili tabloları sil (bağımlılık sırasına göre)
CreditTransaction.destroy_all
Response.destroy_all
Analysis.destroy_all
Survey.destroy_all
ScaleItem.destroy_all
Scale.destroy_all
Project.destroy_all
User.destroy_all

puts "✅ Veritabanı temizlendi"
puts "🌱 Örnek veriler oluşturuluyor...\n"

# ============================================
# 1️⃣ USERS (Kullanıcılar)
# ============================================
puts "👤 Users oluşturuluyor..."

user1 = User.create!(
  email: "ahmet.yilmaz@example.com",
  name: "Ahmet Yılmaz",
  role: :researcher,
  password: "123456",
  credits_balance: 1000
)

user2 = User.create!(
  email: "ayse.demir@example.com",
  name: "Ayşe Demir",
  role: :clinician,
  password: "123456",
  credits_balance: 750
)

user3 = User.create!(
  email: "mehmet.kaya@example.com",
  name: "Mehmet Kaya",
  role: :student,
  password: "123456",
  credits_balance: 250
)

admin = User.create!(
  email: "admin@example.com",
  name: "Admin User",
  role: :admin,
  password: "admin123",
  credits_balance: 10000
)

puts "✅ #{User.count} user oluşturuldu\n"

# ============================================
# 2️⃣ PROJECTS (Projeler)
# ============================================
puts "📁 Projects oluşturuluyor..."

project1 = Project.create!(
  title: "Hastane Memnuniyet Araştırması",
  description: "2024 yılı hasta memnuniyet ve hizmet kalitesi değerlendirme çalışması",
  user: user1,
  status: :active,
  credit_allocated: 500,
  credit_used: 85
)

project2 = Project.create!(
  title: "Öğrenci Motivasyon Analizi",
  description: "Üniversite öğrencilerinde akademik motivasyon faktörleri",
  user: user2,
  status: :active,
  credit_allocated: 300,
  credit_used: 45
)

project3 = Project.create!(
  title: "İş Tatmini Araştırması",
  description: "Şirket çalışanları iş tatmini ve bağlılık analizi",
  user: user1,
  status: :draft,
  credit_allocated: 400,
  credit_used: 0
)

project4 = Project.create!(
  title: "Tüketici Davranışları Anketi",
  description: "Online alışveriş tüketici davranışları ve tercihleri",
  user: user3,
  status: :completed,
  credit_allocated: 200,
  credit_used: 200
)

puts "✅ #{Project.count} project oluşturuldu\n"

# ============================================
# 3️⃣ SCALES (Ölçekler)
# ============================================
puts "📏 Scales oluşturuluyor..."

scale1 = Scale.create!(
  title: "Hasta Memnuniyet Ölçeği",
  description: "Hastane hizmet kalitesi ve memnuniyet değerlendirme ölçeği",
  doi_identifier: "10.1234/hmo.2024",
  version: "2.0",
  language: "tr",
  category: "health",
  status: :published,
  user: user1
)

scale2 = Scale.create!(
  title: "Akademik Motivasyon Ölçeği",
  description: "Öğrenci motivasyon düzeyi belirleme ölçeği",
  doi_identifier: "10.1234/amo.2024",
  version: "1.5",
  language: "tr",
  category: "education",
  status: :published,
  user: user2
)

scale3 = Scale.create!(
  title: "İş Tatmini Ölçeği",
  description: "Minnesota İş Tatmini Ölçeği Türkçe Uyarlaması",
  doi_identifier: "10.1234/ito.2024",
  version: "3.0",
  language: "tr",
  category: "business",
  status: :published,
  user: user1
)

scale4 = Scale.create!(
  title: "Tüketici Davranışı Ölçeği",
  description: "Online alışveriş davranış ve tercih ölçeği",
  version: "1.0",
  language: "tr",
  category: "marketing",
  status: :draft,
  user: user3
)

puts "✅ #{Scale.count} scale oluşturuldu\n"

# ============================================
# 4️⃣ SCALE ITEMS (Ölçek Maddeleri)
# ============================================
puts "📝 Scale Items oluşturuluyor..."

# Hasta Memnuniyet Ölçeği Maddeleri
ScaleItem.create!([
  {
    content: "Hastanemizin genel temizliğinden memnun musunuz?",
    item_type: :likert,
    order: 1,
    scale: scale1,
    options: { min: 1, max: 5, labels: { 1 => "Hiç Memnun Değilim", 5 => "Çok Memnunum" } }
  },
  {
    content: "Sağlık personelinin ilgi ve alakasından memnun musunuz?",
    item_type: :likert,
    order: 2,
    scale: scale1,
    options: { min: 1, max: 5 }
  },
  {
    content: "Muayene ve tedavi süreçlerinden memnun musunuz?",
    item_type: :likert,
    order: 3,
    scale: scale1,
    options: { min: 1, max: 5 }
  },
  {
    content: "Hastaneyi başkalarına tavsiye eder misiniz?",
    item_type: :boolean,
    order: 4,
    scale: scale1,
    options: { true_label: "Evet", false_label: "Hayır" }
  },
  {
    content: "Hastanemiz hakkındaki görüş ve önerileriniz nelerdir?",
    item_type: :open_ended,
    order: 5,
    scale: scale1
  }
])

# Akademik Motivasyon Ölçeği Maddeleri
ScaleItem.create!([
  {
    content: "Derslerime düzenli olarak çalışırım",
    item_type: :likert,
    order: 1,
    scale: scale2,
    options: { min: 1, max: 5 }
  },
  {
    content: "Başarılı olmak benim için önemlidir",
    item_type: :likert,
    order: 2,
    scale: scale2,
    options: { min: 1, max: 5 }
  },
  {
    content: "Öğrendiklerimi gerçek hayatta kullanabileceğime inanıyorum",
    item_type: :likert,
    order: 3,
    scale: scale2,
    options: { min: 1, max: 5 }
  },
  {
    content: "Hangi alanda uzmanlaşmak istiyorsunuz?",
    item_type: :multiple_choice,
    order: 4,
    scale: scale2,
    options: { choices: ["Tıp", "Mühendislik", "Sosyal Bilimler", "Eğitim", "Diğer"] }
  }
])

# İş Tatmini Ölçeği Maddeleri
ScaleItem.create!([
  {
    content: "İşimden genel olarak memnunum",
    item_type: :likert,
    order: 1,
    scale: scale3,
    options: { min: 1, max: 5 }
  },
  {
    content: "Çalışma arkadaşlarımla iyi geçiniyorum",
    item_type: :likert,
    order: 2,
    scale: scale3,
    options: { min: 1, max: 5 }
  },
  {
    content: "Aldığım ücret adil",
    item_type: :likert,
    order: 3,
    scale: scale3,
    options: { min: 1, max: 5 }
  }
])

puts "✅ #{ScaleItem.count} scale item oluşturuldu\n"

# ============================================
# 5️⃣ SURVEYS (Anketler)
# ============================================
puts "📊 Surveys oluşturuluyor..."

survey1 = Survey.create!(
  title: "2024 Hasta Memnuniyet Anketi",
  description: "Yıl sonu değerlendirme anketi",
  project: project1,
  scale: scale1,
  distribution_mode: :link,
  status: :active,
  start_date: Date.today - 15.days,
  end_date: Date.today + 15.days,
  settings: { 
    anonymous: true, 
    show_progress: true,
    allow_multiple: false
  }
)

survey2 = Survey.create!(
  title: "Güz Dönemi Motivasyon Anketi",
  description: "Öğrenci motivasyon düzeyi belirleme",
  project: project2,
  scale: scale2,
  distribution_mode: :email,
  status: :active,
  start_date: Date.today - 7.days,
  end_date: Date.today + 23.days,
  settings: { 
    anonymous: false,
    show_progress: true
  }
)

survey3 = Survey.create!(
  title: "Çalışan Memnuniyet Anketi 2024",
  description: "Yıllık iş tatmini değerlendirmesi",
  project: project3,
  scale: scale3,
  distribution_mode: :panel,
  status: :draft,
  start_date: Date.today + 5.days,
  end_date: Date.today + 35.days
)

puts "✅ #{Survey.count} survey oluşturuldu\n"

# ============================================
# 6️⃣ RESPONSES (Yanıtlar)
# ============================================
puts "💬 Responses oluşturuluyor..."

# Survey 1 için 25 tamamlanmış yanıt
25.times do |i|
  Response.create!(
    survey: survey1,
    participant_id: "PART#{1000 + i}",
    response_data: {
      q1: rand(3..5),
      q2: rand(3..5),
      q3: rand(2..5),
      q4: [true, false].sample,
      q5: ["Çok memnunum", "Güzel hizmet", "İlgili personel", "Teşekkürler"].sample
    },
    completed_at: Time.current - rand(1..360).hours
  )
end

# Survey 2 için 18 tamamlanmış yanıt
18.times do |i|
  Response.create!(
    survey: survey2,
    participant_id: "STU#{2000 + i}",
    response_data: {
      q1: rand(2..5),
      q2: rand(3..5),
      q3: rand(2..5),
      q4: ["Tıp", "Mühendislik", "Sosyal Bilimler", "Eğitim"].sample
    },
    completed_at: Time.current - rand(1..168).hours
  )
end

# Survey 1 için 5 tamamlanmamış yanıt
5.times do |i|
  Response.create!(
    survey: survey1,
    participant_id: "PART#{2000 + i}",
    response_data: {
      q1: rand(1..5),
      q2: rand(1..5)
    },
    completed_at: nil
  )
end

puts "✅ #{Response.count} response oluşturuldu (#{Response.where.not(completed_at: nil).count} tamamlanmış)\n"

# ============================================
# 7️⃣ ANALYSES (Analizler)
# ============================================
puts "🔬 Analyses oluşturuluyor..."

analysis1 = Analysis.create!(
  analysis_type: :descriptive,
  project: project1,
  survey: survey1,
  status: :completed,
  credit_cost: 5,
  executed_at: Time.current - 2.days,
  parameters: { 
    variables: ["q1", "q2", "q3"],
    include_missing: false
  },
  results: {
    q1: { mean: 4.32, median: 4, std_dev: 0.68, min: 3, max: 5, count: 25 },
    q2: { mean: 4.56, median: 5, std_dev: 0.58, min: 3, max: 5, count: 25 },
    q3: { mean: 3.84, median: 4, std_dev: 0.95, min: 2, max: 5, count: 25 }
  }
)

analysis2 = Analysis.create!(
  analysis_type: :correlation,
  project: project1,
  survey: survey1,
  status: :completed,
  credit_cost: 8,
  executed_at: Time.current - 1.day,
  parameters: {
    variables: ["q1", "q2"],
    method: "pearson"
  },
  results: {
    correlation: 0.72,
    p_value: 0.001,
    significance: "p < 0.01"
  }
)

analysis3 = Analysis.create!(
  analysis_type: :reliability,
  project: project2,
  survey: survey2,
  status: :completed,
  credit_cost: 10,
  executed_at: Time.current - 3.hours,
  parameters: {
    variables: ["q1", "q2", "q3"],
    method: "cronbach_alpha"
  },
  results: {
    cronbach_alpha: 0.85,
    interpretation: "İyi güvenilirlik"
  }
)

analysis4 = Analysis.create!(
  analysis_type: :regression,
  project: project1,
  survey: survey1,
  status: :pending,
  credit_cost: 10,
  parameters: {
    dependent: "q3",
    independent: ["q1", "q2"]
  }
)

analysis5 = Analysis.create!(
  analysis_type: :factor_analysis,
  project: project2,
  survey: survey2,
  status: :running,
  credit_cost: 15,
  executed_at: Time.current - 30.minutes,
  parameters: {
    variables: ["q1", "q2", "q3"],
    rotation: "varimax"
  }
)

puts "✅ #{Analysis.count} analysis oluşturuldu\n"

# ============================================
# 8️⃣ CREDIT TRANSACTIONS (Kredi İşlemleri)
# ============================================
puts "💳 Credit Transactions oluşturuluyor..."

CreditTransaction.create!([
  {
    user: user1,
    project: project1,  # Analiz ile ilişkili olduğundan project ekledik
    transaction_type: :purchase,
    amount: 1000,
    balance_after: 1000,
    description: "İlk kredi yüklemesi"
  },
  {
    user: user1,
    project: project1,
    transaction_type: :usage,
    amount: -5,
    balance_after: 995,
    description: "Descriptive analysis - Survey 1"
  },
  {
    user: user1,
    project: project1,
    transaction_type: :usage,
    amount: -8,
    balance_after: 987,
    description: "Correlation analysis - Survey 1"
  },
  {
    user: user2,
    project: project2, # NOT NULL için proje ekledik
    transaction_type: :purchase,
    amount: 500,
    balance_after: 500,
    description: "Kredi satın alma"
  },
  {
    user: user2,
    project: project2, # NOT NULL için proje ekledik
    transaction_type: :bonus,
    amount: 250,
    balance_after: 750,
    description: "Hoşgeldin bonusu"
  },
  {
    user: user2,
    project: project2,
    transaction_type: :usage,
    amount: -10,
    balance_after: 740,
    description: "Reliability analysis - Survey 2"
  },
  {
    user: user3,
    project: project4, # NOT NULL için proje ekledik
    transaction_type: :purchase,
    amount: 250,
    balance_after: 250,
    description: "Öğrenci paketi"
  },
  {
    user: admin,
    project: project1, # Admin işlemi için örnek proje ekledik
    transaction_type: :bonus,
    amount: 10000,
    balance_after: 10000,
    description: "Admin hesabı başlangıç kredisi"
  }
])

puts "✅ #{CreditTransaction.count} credit transaction oluşturuldu\n"
# ============================================
# 📊 ÖZET
# ============================================
puts "\n" + "="*60
puts "🎉 TÜM ÖRNEK VERİLER BAŞARIYLA OLUŞTURULDU!"
puts "="*60
puts "\n📊 OLUŞTURULAN VERİLER:"
puts "  👤 Users: #{User.count}"
puts "  📁 Projects: #{Project.count}"
puts "  📏 Scales: #{Scale.count}"
puts "  📝 Scale Items: #{ScaleItem.count}"
puts "  📊 Surveys: #{Survey.count}"
puts "  💬 Responses: #{Response.count} (#{Response.where.not(completed_at: nil).count} tamamlanmış)"
puts "  🔬 Analyses: #{Analysis.count}"
puts "  💳 Credit Transactions: #{CreditTransaction.count}"
puts "\n✅ Tüm API endpointleri artık veri döndürüyor!"
puts "🌐 Test et: http://127.0.0.1:3000/api/v1/users"
puts "="*60 + "\n"
