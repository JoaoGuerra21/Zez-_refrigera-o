import { NavHeader } from "@/components/nav-header"
import { Card, CardContent } from "@/components/ui/card"

export default function SobrePage() {
  return (
    <>
      <NavHeader />
      <main className="min-h-screen bg-gradient-to-b from-blue-50 to-white dark:from-slate-950 dark:to-slate-900">
        {/* Hero Section */}
        <section className="bg-gradient-to-r from-blue-600 to-blue-700 text-white py-12 px-4">
          <div className="container mx-auto">
            <h1 className="text-4xl font-bold mb-4">Sobre Zezé Refrigeração</h1>
            <p className="text-xl text-blue-100">Sistema profissional de gestão de estoque</p>
          </div>
        </section>

        {/* Sobre Section */}
        <section className="container mx-auto px-4 py-20">
          <div className="grid grid-cols-1 md:grid-cols-2 gap-12">
            <div>
              <h2 className="text-3xl font-bold mb-6">Quem Somos</h2>
              <p className="text-lg text-gray-700 dark:text-gray-300 mb-4">
                Zezé Refrigeração é uma empresa especializada em geladeiras, freezers e peças de reposição para sistemas
                de refrigeração. Com anos de experiência no mercado, oferecemos produtos de qualidade e soluções
                completas para seu negócio.
              </p>
              <p className="text-lg text-gray-700 dark:text-gray-300">
                Nosso sistema de gestão de estoque foi desenvolvido para otimizar o controle de inventário, reduzir
                custos operacionais e aumentar a eficiência dos processos de vendas e compras.
              </p>
            </div>
            <div className="text-center">
              <div className="text-9xl mb-6">❄️</div>
              <p className="text-2xl font-bold text-blue-600">Refrigeração Profissional</p>
            </div>
          </div>
        </section>

        {/* Missão Visão Section */}
        <section className="bg-white dark:bg-slate-800 py-20 px-4">
          <div className="container mx-auto">
            <h2 className="text-3xl font-bold text-center mb-12">Nossa Missão e Visão</h2>
            <div className="grid grid-cols-1 md:grid-cols-2 gap-8">
              <Card className="border-2 border-blue-200">
                <CardContent className="pt-8">
                  <h3 className="text-2xl font-bold text-blue-600 mb-4">Missão</h3>
                  <p className="text-gray-700 dark:text-gray-300">
                    Fornecer soluções inovadoras e eficientes em gestão de estoque, ajudando empresas do setor de
                    refrigeração a otimizar suas operações, reduzir custos e aumentar lucratividade.
                  </p>
                </CardContent>
              </Card>

              <Card className="border-2 border-blue-200">
                <CardContent className="pt-8">
                  <h3 className="text-2xl font-bold text-blue-600 mb-4">Visão</h3>
                  <p className="text-gray-700 dark:text-gray-300">
                    Ser a plataforma referência em gestão de estoque para o setor de refrigeração, conhecido pela
                    excelência, confiabilidade e facilidade de uso.
                  </p>
                </CardContent>
              </Card>
            </div>
          </div>
        </section>

        {/* Diferenciais Section */}
        <section className="container mx-auto px-4 py-20">
          <h2 className="text-3xl font-bold text-center mb-12">O Que Nos Diferencia</h2>
          <div className="grid grid-cols-1 md:grid-cols-3 gap-8">
            <Card className="hover:shadow-lg transition-shadow">
              <CardContent className="pt-6">
                <div className="text-4xl mb-4">🎯</div>
                <h3 className="text-xl font-bold mb-3">Precisão</h3>
                <p className="text-gray-600 dark:text-gray-400">
                  Controle exato do estoque com dados em tempo real, evitando perdas e otimizando reposições.
                </p>
              </CardContent>
            </Card>

            <Card className="hover:shadow-lg transition-shadow">
              <CardContent className="pt-6">
                <div className="text-4xl mb-4">⚡</div>
                <h3 className="text-xl font-bold mb-3">Velocidade</h3>
                <p className="text-gray-600 dark:text-gray-400">
                  Interface rápida e responsiva que permite operações ágeis e decisões instantâneas.
                </p>
              </CardContent>
            </Card>

            <Card className="hover:shadow-lg transition-shadow">
              <CardContent className="pt-6">
                <div className="text-4xl mb-4">🔒</div>
                <h3 className="text-xl font-bold mb-3">Segurança</h3>
                <p className="text-gray-600 dark:text-gray-400">
                  Seus dados estão protegidos com as melhores práticas de segurança e criptografia.
                </p>
              </CardContent>
            </Card>
          </div>
        </section>

        {/* Contato Section */}
        <section className="bg-gradient-to-r from-blue-600 to-blue-700 text-white py-20 px-4">
          <div className="container mx-auto text-center">
            <h2 className="text-3xl font-bold mb-6">Entre em Contato</h2>
            <p className="text-xl mb-8 max-w-2xl mx-auto">
              Tem dúvidas sobre nosso sistema? Quer conhecer mais sobre como podemos ajudar seu negócio?
            </p>
            <div className="grid grid-cols-1 md:grid-cols-3 gap-8 mt-12">
              <div>
                <div className="text-3xl mb-3">📱</div>
                <p className="font-semibold">Telefone</p>
                <p className="text-blue-100">(11) 9999-9999</p>
              </div>
              <div>
                <div className="text-3xl mb-3">📧</div>
                <p className="font-semibold">Email</p>
                <p className="text-blue-100">contato@zezerefrigeracao.com.br</p>
              </div>
              <div>
                <div className="text-3xl mb-3">📍</div>
                <p className="font-semibold">Localização</p>
                <p className="text-blue-100">São Paulo, SP</p>
              </div>
            </div>
          </div>
        </section>

        {/* Footer */}
        <footer className="bg-gray-900 text-gray-400 py-8 px-4">
          <div className="container mx-auto text-center">
            <p>&copy; 2025 Zezé Refrigeração. Todos os direitos reservados.</p>
            <p className="mt-2">Sistema de Gestão de Estoque Profissional</p>
          </div>
        </footer>
      </main>
    </>
  )
}
