import { DatabaseDashboard } from "@/components/database-dashboard"

export default function Home() {
  return (
    <main className="min-h-screen bg-background">
      <div className="bg-blue-600 text-white py-3 px-4 shadow-sm">
        <div className="container mx-auto text-center">
          <p className="text-sm font-medium">❄️ Zezé Refrigeração - Sistema de Gestão Profissional</p>
        </div>
      </div>
      <DatabaseDashboard />
    </main>
  )
}
