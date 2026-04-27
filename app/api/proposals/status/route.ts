import { NextRequest, NextResponse } from "next/server";
import { getSupabaseAdminClient } from "@/lib/supabase";

const ALLOWED_STATUSES = [
  'submitted',
  'pending payment',
  'payment successful',
  'accepted',
  'rejected',
];

export async function PATCH(request: NextRequest) {
  try {
    const body = await request.json();
    const proposalId = body?.proposalId;
    const status = body?.status;

    if (!proposalId || !status) {
      return NextResponse.json({ error: 'Proposal ID and status are required' }, { status: 400 });
    }

    if (!ALLOWED_STATUSES.includes(status)) {
      return NextResponse.json({ error: 'Invalid status value' }, { status: 400 });
    }

    const supabase = getSupabaseAdminClient();
    const { data, error } = await supabase
      .from('proposals')
      .update({ status })
      .eq('id', proposalId)
      .select()
      .single();

    if (error) {
      return NextResponse.json({ error: error.message }, { status: 500 });
    }

    return NextResponse.json({ success: true, data });
  } catch (error) {
    const message = error instanceof Error ? error.message : 'Failed to update proposal status';
    return NextResponse.json({ error: message }, { status: 500 });
  }
}
