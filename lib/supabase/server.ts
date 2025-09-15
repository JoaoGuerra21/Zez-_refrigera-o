export async function createClient() {
  // Usar apenas as variáveis de ambiente padrão do Supabase
  const supabaseUrl = process.env.NEXT_PUBLIC_SUPABASE_URL
  const supabaseKey = process.env.NEXT_PUBLIC_SUPABASE_ANON_KEY

  if (!supabaseUrl || !supabaseKey) {
    console.log("[v0] Supabase environment variables not found")
    return null
  }

  // Retornar um cliente mock para demonstração no servidor
  return {
    from: (table: string) => ({
      select: (columns: string, options?: any) => ({
        eq: (column: string, value: any) => ({
          single: () => Promise.resolve({ data: null, error: null }),
        }),
        then: (callback: any) => callback({ data: [], error: null, count: 0 }),
      }),
      insert: (data: any) => Promise.resolve({ data: null, error: null }),
      update: (data: any) => Promise.resolve({ data: null, error: null }),
      delete: () => Promise.resolve({ data: null, error: null }),
    }),
  }
}
