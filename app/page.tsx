import { NavHeader } from "@/components/nav-header"
import { Button } from "@/components/ui/button"
import { Card, CardContent } from "@/components/ui/card"
import Link from "next/link"

export default function Home() {
  return (
    <>
      <NavHeader />
      <main className="min-h-screen bg-gradient-to-b from-blue-50 to-white dark:from-slate-950 dark:to-slate-900">
        {/* Hero Section */}
        <section className="container mx-auto px-4 py-20">
          <div className="grid grid-cols-1 md:grid-cols-2 gap-12 items-center">
            <div>
              <div className="text-5xl font-bold text-blue-600 mb-4">Zezé Refrigeração</div>
              <p className="text-xl text-gray-600 dark:text-gray-300 mb-6">
                Sistema profissional de gestão de estoque para geladeiras, freezers e peças de reposição.
              </p>
              <p className="text-lg text-gray-500 dark:text-gray-400 mb-8">
                Organize seu negócio, reduza custos e aumente a eficiência com nossa plataforma completa.
              </p>
              <div className="flex gap-4">
                <Link href="/dados">
                  <Button size="lg" className="bg-blue-600 hover:bg-blue-700">
                    Ver Dados
                  </Button>
                </Link>
              </div>
            </div>
            <div className="text-center">
              <div className="text-8xl">❄️</div>
              <p className="text-2xl font-bold mt-4 text-blue-600">Tecnologia em Refrigeração</p>
            </div>
          </div>
        </section>

        {/* Features Section */}
        <section className="bg-white dark:bg-slate-800 py-20">
          <div className="container mx-auto px-4">
            <h2 className="text-4xl font-bold text-center mb-16">Funcionalidades Principais</h2>
            <div className="grid grid-cols-1 md:grid-cols-3 gap-8">
              <Card className="hover:shadow-lg transition-shadow">
                <CardContent className="pt-6 text-center">
                  <div className="text-5xl mb-4">📦</div>
                  <h3 className="text-xl font-bold mb-2">Gestão de Estoque</h3>
                  <p className="text-gray-600 dark:text-gray-400">
                    Controle completo de produtos, quantidades e localização em tempo real.
                  </p>
                </CardContent>
              </Card>

              <Card className="hover:shadow-lg transition-shadow">
                <CardContent className="pt-6 text-center">
                  <div className="text-5xl mb-4">👥</div>
                  <h3 className="text-xl font-bold mb-2">Fornecedores</h3>
                  <p className="text-gray-600 dark:text-gray-400">
                    Cadastre e gerencie seus fornecedores com prazos de entrega e condições de pagamento.
                  </p>
                </CardContent>
              </Card>

              <Card className="hover:shadow-lg transition-shadow">
                <CardContent className="pt-6 text-center">
                  <div className="text-5xl mb-4">💰</div>
                  <h3 className="text-xl font-bold mb-2">Análise de Custos</h3>
                  <p className="text-gray-600 dark:text-gray-400">
                    Monitore margens de lucro, custos de estoque e rentabilidade dos produtos.
                  </p>
                </CardContent>
              </Card>

              <Card className="hover:shadow-lg transition-shadow">
                <CardContent className="pt-6 text-center">
                  <div className="text-5xl mb-4">📊</div>
                  <h3 className="text-xl font-bold mb-2">Relatórios</h3>
                  <p className="text-gray-600 dark:text-gray-400">
                    Gere relatórios detalhados sobre vendas, compras e análise de rotatividade.
                  </p>
                </CardContent>
              </Card>

              <Card className="hover:shadow-lg transition-shadow">
                <CardContent className="pt-6 text-center">
                  <div className="text-5xl mb-4">⚠️</div>
                  <h3 className="text-xl font-bold mb-2">Alertas Inteligentes</h3>
                  <p className="text-gray-600 dark:text-gray-400">
                    Receba notificações de estoque baixo e produtos que precisam ser repostos.
                  </p>
                </CardContent>
              </Card>

              <Card className="hover:shadow-lg transition-shadow">
                <CardContent className="pt-6 text-center">
                  <div className="text-5xl mb-4">🔧</div>
                  <h3 className="text-xl font-bold mb-2">Ferramentas</h3>
                  <p className="text-gray-600 dark:text-gray-400">
                    Gerencie seu estoque de ferramentas com preços, estoque e análise de rotatividade.
                  </p>
                </CardContent>
              </Card>

              <Card className="hover:shadow-lg transition-shadow">
                <CardContent className="pt-6 text-center">
                  <div className="text-5xl mb-4">🔧</div>
                  <h3 className="text-xl font-bold mb-2">Fácil de Usar</h3>
                  <p className="text-gray-600 dark:text-gray-400">
                    Interface intuitiva que qualquer pessoa consegue usar sem treinamento.
                  </p>
                </CardContent>
              </Card>
            </div>
          </div>
        </section>

        {/* Stats Section */}
        <section className="py-20">
          <div className="container mx-auto px-4">
            <div className="grid grid-cols-1 md:grid-cols-4 gap-8">
              <Card className="text-center">
                <CardContent className="pt-6">
                  <div className="text-4xl font-bold text-blue-600 mb-2">25+</div>
                  <p className="text-gray-600 dark:text-gray-400">Produtos Cadastrados</p>
                </CardContent>
              </Card>
              <Card className="text-center">
                <CardContent className="pt-6">
                  <div className="text-4xl font-bold text-blue-600 mb-2">8</div>
                  <p className="text-gray-600 dark:text-gray-400">Fornecedores Ativos</p>
                </CardContent>
              </Card>
              <Card className="text-center">
                <CardContent className="pt-6">
                  <div className="text-4xl font-bold text-blue-600 mb-2">300+</div>
                  <p className="text-gray-600 dark:text-gray-400">Peças em Estoque</p>
                </CardContent>
              </Card>
              <Card className="text-center">
                <CardContent className="pt-6">
                  <div className="text-4xl font-bold text-blue-600 mb-2">100%</div>
                  <p className="text-gray-600 dark:text-gray-400">Precisão de Dados</p>
                </CardContent>
              </Card>
            </div>
          </div>
        </section>

        {/* CTA Section */}
        <section className="bg-gradient-to-r from-blue-600 to-blue-700 text-white py-20">
          <div className="container mx-auto px-4 text-center">
            <h2 className="text-4xl font-bold mb-6">Pronto para começar?</h2>
            <p className="text-xl mb-8 opacity-90">Acesse seus dados e comece a gerenciar seu estoque agora mesmo.</p>
            <Link href="/dados">
              <Button size="lg" className="bg-white text-blue-600 hover:bg-gray-100">
                Ir para os Dados
              </Button>
            </Link>
          </div>
        </section>

        {/* Footer */}
        <footer className="bg-gray-900 text-gray-400 py-8">
          <div className="container mx-auto px-4 text-center">
            <p>&copy; 2025 Zezé Refrigeração. Todos os direitos reservados.</p>
            <p className="mt-2">Sistema de Gestão de Estoque Profissional</p>
          </div>
        </footer>
      </main>
    </>
  )
}
