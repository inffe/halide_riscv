	.text
	.attribute	4, 16
	.attribute	5, "rv64gcv0p7"
	.file	"halide_buffer_t.cpp"
	.section	.text.deconvolution,"ax",@progbits
	.globl	deconvolution                   # -- Begin function deconvolution
	.p2align	1
	.type	deconvolution,@function
deconvolution:                          # @deconvolution
# %bb.0:                                # %entry
	addi	sp, sp, -448
	sd	ra, 440(sp)                     # 8-byte Folded Spill
	sd	s0, 432(sp)                     # 8-byte Folded Spill
	sd	s1, 424(sp)                     # 8-byte Folded Spill
	sd	s2, 416(sp)                     # 8-byte Folded Spill
	sd	s3, 408(sp)                     # 8-byte Folded Spill
	sd	s4, 400(sp)                     # 8-byte Folded Spill
	sd	s5, 392(sp)                     # 8-byte Folded Spill
	sd	s6, 384(sp)                     # 8-byte Folded Spill
	sd	s7, 376(sp)                     # 8-byte Folded Spill
	sd	s8, 368(sp)                     # 8-byte Folded Spill
	sd	s9, 360(sp)                     # 8-byte Folded Spill
	sd	s10, 352(sp)                    # 8-byte Folded Spill
	sd	s11, 344(sp)                    # 8-byte Folded Spill
	ld	a4, 40(a1)
	ld	s3, 16(a1)
	lw	a2, 0(a4)
	sd	a2, 80(sp)                      # 8-byte Folded Spill
	lw	t0, 16(a4)
	lw	a2, 24(a4)
	sd	a2, 160(sp)                     # 8-byte Folded Spill
	lw	a7, 32(a4)
	lw	a2, 40(a4)
	sd	a2, 136(sp)                     # 8-byte Folded Spill
	lw	t1, 48(a4)
	lw	a2, 56(a4)
	sd	a2, 88(sp)                      # 8-byte Folded Spill
	ld	s2, 16(a0)
.Lpcrel_hi0:
	auipc	a2, %pcrel_hi(.Lweights.buffer)
	addi	a2, a2, %pcrel_lo(.Lpcrel_hi0)
	ld	s10, 16(a2)
	mv	a6, s3
	beqz	s3, .LBB0_4
# %bb.1:                                # %after_bb
	mv	a4, s2
	beqz	s2, .LBB0_9
.LBB0_2:                                # %after_bb1
	ld	a5, 16(a2)
	beqz	a5, .LBB0_11
.LBB0_3:
	li	a5, 0
	j	.LBB0_19
.LBB0_4:                                # %_halide_buffer_is_bounds_query.exit
	ld	a3, 0(a1)
	beqz	a3, .LBB0_6
# %bb.5:
	li	a6, 0
	mv	a4, s2
	bnez	s2, .LBB0_2
	j	.LBB0_9
.LBB0_6:                                # %then_bb
	sw	zero, 168(sp)
	li	a3, 200
	sw	a3, 172(sp)
	li	a5, 1
	sw	a5, 176(sp)
	sw	zero, 180(sp)
	sw	zero, 184(sp)
	sw	a3, 188(sp)
	sw	a3, 192(sp)
	sw	zero, 196(sp)
	sw	zero, 200(sp)
	li	a3, 144
	sw	a3, 204(sp)
	lui	a3, 10
	addiw	a3, a3, -960
	sw	a3, 208(sp)
	sw	zero, 212(sp)
	sw	zero, 216(sp)
	li	a3, 4
	sw	a3, 220(sp)
	lui	a5, 1406
	addiw	a5, a5, 1024
	sw	a5, 224(sp)
	sw	zero, 228(sp)
	sd	zero, 16(a1)
	sd	zero, 8(a1)
	lui	a5, 512
	addiw	a5, a5, 9
	slli	a5, a5, 13
	addi	a5, a5, 2
	sd	a5, 32(a1)
	addi	a5, sp, 168
	sd	zero, 0(a1)
	beq	a5, a4, .LBB0_8
.LBB0_7:                                # %for.body.i
                                        # =>This Inner Loop Header: Depth=1
	lw	s1, 12(a5)
	sw	s1, 12(a4)
	lw	s1, 8(a5)
	sw	s1, 8(a4)
	lw	s1, 4(a5)
	sw	s1, 4(a4)
	lw	s1, 0(a5)
	sw	s1, 0(a4)
	addi	a3, a3, -1
	addi	a4, a4, 16
	addi	a5, a5, 16
	bnez	a3, .LBB0_7
.LBB0_8:                                # %_halide_buffer_init.exit
	li	a6, 0
	sd	zero, 24(a1)
	mv	a4, s2
	bnez	s2, .LBB0_2
.LBB0_9:                                # %_halide_buffer_is_bounds_query.exit133
	ld	a4, 0(a0)
	beqz	a4, .LBB0_13
# %bb.10:
	li	a4, 0
	ld	a5, 16(a2)
	bnez	a5, .LBB0_3
.LBB0_11:                               # %_halide_buffer_is_bounds_query.exit140
	ld	a5, 0(a2)
	beqz	a5, .LBB0_16
.LBB0_12:                               # %land.rhs.i161
	seqz	a5, a5
	j	.LBB0_19
.LBB0_13:                               # %then_bb2
	ld	a4, 40(a0)
	sw	zero, 232(sp)
	li	a5, 100
	sw	a5, 236(sp)
	li	s1, 1
	sw	s1, 240(sp)
	sw	zero, 244(sp)
	sw	zero, 248(sp)
	sw	a5, 252(sp)
	sw	a5, 256(sp)
	sw	zero, 260(sp)
	sw	zero, 264(sp)
	li	a5, 72
	sw	a5, 268(sp)
	lui	a5, 2
	addiw	a5, a5, 1808
	sw	a5, 272(sp)
	sw	zero, 276(sp)
	sw	zero, 280(sp)
	li	a5, 4
	sw	a5, 284(sp)
	lui	s1, 176
	addiw	s1, s1, -896
	sw	s1, 288(sp)
	sw	zero, 292(sp)
	sd	zero, 16(a0)
	sd	zero, 8(a0)
	lui	s1, 512
	addiw	s1, s1, 9
	slli	s1, s1, 13
	addi	s1, s1, 2
	sd	s1, 32(a0)
	addi	s1, sp, 232
	sd	zero, 0(a0)
	beq	s1, a4, .LBB0_15
.LBB0_14:                               # %for.body.i156
                                        # =>This Inner Loop Header: Depth=1
	lw	s0, 12(s1)
	sw	s0, 12(a4)
	lw	s0, 8(s1)
	sw	s0, 8(a4)
	lw	s0, 4(s1)
	sw	s0, 4(a4)
	lw	s0, 0(s1)
	sw	s0, 0(a4)
	addi	a5, a5, -1
	addi	a4, a4, 16
	addi	s1, s1, 16
	bnez	a5, .LBB0_14
.LBB0_15:                               # %_halide_buffer_init.exit158
	li	a4, 0
	sd	zero, 24(a0)
	ld	a5, 16(a2)
	bnez	a5, .LBB0_3
	j	.LBB0_11
.LBB0_16:                               # %then_bb5
	sw	zero, 296(sp)
	li	a5, 4
	sw	a5, 300(sp)
	li	s1, 1
	sw	s1, 304(sp)
	sw	zero, 308(sp)
	sw	zero, 312(sp)
	sw	a5, 316(sp)
	sw	a5, 320(sp)
	sw	zero, 324(sp)
	sw	zero, 328(sp)
	sw	a5, 332(sp)
	li	a5, 16
	sw	a5, 336(sp)
	sw	zero, 340(sp)
	sd	zero, 0(a2)
	sd	zero, 8(a2)
	sd	zero, 16(a2)
	lui	a5, 384
	addiw	a5, a5, 9
	slli	a5, a5, 13
	addi	s1, a5, 2
	ld	a5, 40(a2)
	sd	s1, 32(a2)
	li	s1, 3
	addi	s0, sp, 296
.LBB0_17:                               # %for.body.i180
                                        # =>This Inner Loop Header: Depth=1
	lw	a3, 12(s0)
	sw	a3, 12(a5)
	lw	a3, 8(s0)
	sw	a3, 8(a5)
	lw	a3, 4(s0)
	sw	a3, 4(a5)
	lw	a3, 0(s0)
	sw	a3, 0(a5)
	addi	s1, s1, -1
	addi	a5, a5, 16
	addi	s0, s0, 16
	bnez	s1, .LBB0_17
# %bb.18:                               # %after_bb4
	ld	s1, 16(a2)
	li	a5, 0
	sd	zero, 24(a2)
	beqz	s1, .LBB0_54
.LBB0_19:                               # %_halide_buffer_is_bounds_query.exit162
	beqz	a6, .LBB0_22
# %bb.20:
	li	a1, 0
	beqz	a4, .LBB0_23
.LBB0_21:
	li	a0, 0
	or	a0, a0, a5
	or	a0, a0, a1
	beqz	a0, .LBB0_24
	j	.LBB0_53
.LBB0_22:                               # %land.rhs.i166
	ld	a1, 0(a1)
	seqz	a1, a1
	bnez	a4, .LBB0_21
.LBB0_23:                               # %land.rhs.i171
	ld	a0, 0(a0)
	seqz	a0, a0
	or	a0, a0, a5
	or	a0, a0, a1
	bnez	a0, .LBB0_53
.LBB0_24:                               # %then_bb8
	sd	t1, 24(sp)                      # 8-byte Folded Spill
	sd	t0, 16(sp)                      # 8-byte Folded Spill
	sd	a7, 32(sp)                      # 8-byte Folded Spill
	lui	a0, 22121
	addiw	s0, a0, -528
	li	a0, 0
	mv	a1, s0
	call	halide_malloc@plt
	mv	s5, a0
	li	a1, 0
	mv	a2, s0
	call	memset@plt
	li	t1, 0
	li	a1, 100
	lui	a0, 77
	addiw	t4, a0, 1416
	lui	a0, 10
	addiw	t5, a0, -960
	li	t3, 72
	lui	a0, 5530
	addiw	a7, a0, 892
	lui	a0, 703
	addiw	t0, a0, 512
	li	a6, 4
	mv	t2, s5
.LBB0_25:                               # %"for dilated_input.s1.c"
                                        # =>This Loop Header: Depth=1
                                        #     Child Loop BB0_26 Depth 2
                                        #       Child Loop BB0_27 Depth 3
                                        #         Child Loop BB0_28 Depth 4
	li	t6, 0
	mv	s4, s2
	mv	s0, t2
.LBB0_26:                               # %"for dilated_input.s1.r4$z"
                                        #   Parent Loop BB0_25 Depth=1
                                        # =>  This Loop Header: Depth=2
                                        #       Child Loop BB0_27 Depth 3
                                        #         Child Loop BB0_28 Depth 4
	li	a0, 0
	mv	a3, s4
	mv	a2, s0
.LBB0_27:                               # %"for dilated_input.s1.r4$y"
                                        #   Parent Loop BB0_25 Depth=1
                                        #     Parent Loop BB0_26 Depth=2
                                        # =>    This Loop Header: Depth=3
                                        #         Child Loop BB0_28 Depth 4
	li	a4, 100
	mv	s1, a3
	mv	a5, a2
.LBB0_28:                               # %"for dilated_input.s1.r4$x"
                                        #   Parent Loop BB0_25 Depth=1
                                        #     Parent Loop BB0_26 Depth=2
                                        #       Parent Loop BB0_27 Depth=3
                                        # =>      This Inner Loop Header: Depth=4
	flw	ft0, 0(s1)
	fsw	ft0, 0(a5)
	addi	a4, a4, -1
	addi	a5, a5, 8
	addi	s1, s1, 4
	bnez	a4, .LBB0_28
# %bb.29:                               # %"end for dilated_input.s1.r4$x"
                                        #   in Loop: Header=BB0_27 Depth=3
	addi	a0, a0, 1
	addi	a2, a2, 1592
	addi	a3, a3, 400
	bne	a0, a1, .LBB0_27
# %bb.30:                               # %"end for dilated_input.s1.r4$y"
                                        #   in Loop: Header=BB0_26 Depth=2
	addi	t6, t6, 1
	add	s0, s0, t4
	add	s4, s4, t5
	bne	t6, t3, .LBB0_26
# %bb.31:                               # %"end for dilated_input.s1.r4$z"
                                        #   in Loop: Header=BB0_25 Depth=1
	addi	t1, t1, 1
	add	t2, t2, a7
	add	s2, s2, t0
	bne	t1, a6, .LBB0_25
# %bb.32:                               # %"end for dilated_input.s1.c"
	lui	a0, 23663
	addiw	a1, a0, -80
	li	a0, 0
	call	halide_malloc@plt
	li	a3, 0
	lui	a2, 121
	addiw	a1, a2, 1328
	sd	a0, 152(sp)                     # 8-byte Folded Spill
	add	s4, a0, a1
	lui	a1, 5916
	addiw	a4, a1, -1044
	lui	a1, 5876
	addiw	a0, a1, -2040
	sd	a0, 64(sp)                      # 8-byte Folded Spill
	lui	a1, 161
	addiw	a0, a1, -924
	sd	a0, 56(sp)                      # 8-byte Folded Spill
	addiw	a0, a2, -1108
	sd	a0, 48(sp)                      # 8-byte Folded Spill
	lui	a0, 40
	addiw	s0, a0, 996
	lui	a0, 1
	addiw	a0, a0, -1660
	sd	a0, 128(sp)                     # 8-byte Folded Spill
	lui	a0, 39
	addiw	a0, a0, -1340
	sd	a0, 120(sp)                     # 8-byte Folded Spill
	lui	a0, 5530
	addiw	a0, a0, 892
	sd	a0, 40(sp)                      # 8-byte Folded Spill
	sd	s5, 8(sp)                       # 8-byte Folded Spill
	sd	a4, 72(sp)                      # 8-byte Folded Spill
.LBB0_33:                               # %"for constant_exterior.s0.c"
                                        # =>This Loop Header: Depth=1
                                        #     Child Loop BB0_34 Depth 2
                                        #       Child Loop BB0_35 Depth 3
	sd	a3, 112(sp)                     # 8-byte Folded Spill
	mul	s2, a3, a4
	ld	a0, 152(sp)                     # 8-byte Folded Reload
	add	a0, a0, s2
	ld	a1, 64(sp)                      # 8-byte Folded Reload
	add	a1, a1, a0
	sd	a1, 96(sp)                      # 8-byte Folded Spill
	ld	a1, 56(sp)                      # 8-byte Folded Reload
	add	a1, a1, s2
	sd	a1, 144(sp)                     # 8-byte Folded Spill
	ld	a2, 48(sp)                      # 8-byte Folded Reload
	add	s2, s2, a2
	li	a1, 0
	call	memset@plt
	li	s11, 0
	sd	s5, 104(sp)                     # 8-byte Folded Spill
	mv	s9, s4
.LBB0_34:                               # %"for constant_exterior.s0.d"
                                        #   Parent Loop BB0_33 Depth=1
                                        # =>  This Loop Header: Depth=2
                                        #       Child Loop BB0_35 Depth 3
	mul	a0, s11, s0
	ld	s8, 144(sp)                     # 8-byte Folded Reload
	add	s8, s8, a0
	ld	a1, 152(sp)                     # 8-byte Folded Reload
	add	s8, s8, a1
	add	a0, a0, s2
	add	a0, a0, a1
	li	a1, 0
	ld	a2, 128(sp)                     # 8-byte Folded Reload
	call	memset@plt
	li	s6, 199
	mv	s1, s5
	mv	s7, s4
.LBB0_35:                               # %"for constant_exterior.s0.y"
                                        #   Parent Loop BB0_33 Depth=1
                                        #     Parent Loop BB0_34 Depth=2
                                        # =>    This Inner Loop Header: Depth=3
	addi	a0, s7, 12
	sw	zero, 8(s7)
	sw	zero, 4(s7)
	sw	zero, 0(s7)
	li	a2, 796
	mv	a1, s1
	call	memcpy@plt
	sw	zero, 808(s7)
	addi	s6, s6, -1
	addi	s7, s7, 812
	addi	s1, s1, 796
	bnez	s6, .LBB0_35
# %bb.36:                               # %"for constant_exterior.s0.x.rebased19.preheader"
                                        #   in Loop: Header=BB0_34 Depth=2
	li	a2, 812
	mv	a0, s8
	li	a1, 0
	call	memset@plt
	addi	s11, s11, 1
	add	s4, s4, s0
	ld	a0, 120(sp)                     # 8-byte Folded Reload
	add	s5, s5, a0
	li	a0, 143
	bne	s11, a0, .LBB0_34
# %bb.37:                               # %"for constant_exterior.s0.y.rebased22.preheader"
                                        #   in Loop: Header=BB0_33 Depth=1
	ld	a0, 96(sp)                      # 8-byte Folded Reload
	li	a1, 0
	mv	a2, s0
	call	memset@plt
	ld	a3, 112(sp)                     # 8-byte Folded Reload
	addi	a3, a3, 1
	mv	s4, s9
	ld	a4, 72(sp)                      # 8-byte Folded Reload
	add	s4, s9, a4
	ld	a0, 40(sp)                      # 8-byte Folded Reload
	ld	s5, 104(sp)                     # 8-byte Folded Reload
	add	s5, s5, a0
	li	a0, 4
	bne	a3, a0, .LBB0_33
# %bb.38:                               # %call_destructor.exit
	li	a0, 0
	ld	a1, 8(sp)                       # 8-byte Folded Reload
	call	halide_free@plt
	li	t0, 0
	ld	a0, 160(sp)                     # 8-byte Folded Reload
	ld	a1, 16(sp)                      # 8-byte Folded Reload
	mulw	a0, a0, a1
	ld	a1, 136(sp)                     # 8-byte Folded Reload
	ld	a2, 32(sp)                      # 8-byte Folded Reload
	mulw	a1, a1, a2
	ld	a2, 88(sp)                      # 8-byte Folded Reload
	ld	a3, 24(sp)                      # 8-byte Folded Reload
	mulw	t6, a2, a3
	add	a0, a0, a1
	add	t6, t6, a0
	lui	a0, 121
	addiw	a7, a0, 1340
	ld	a0, 152(sp)                     # 8-byte Folded Reload
	add	a7, a7, a0
	fmv.w.x	ft0, zero
	li	a3, 4
	lui	a0, 1048536
	addiw	ra, a0, -996
	li	s7, 200
	lui	a0, 40
	addiw	t2, a0, 996
	li	t1, 144
	lui	a0, 5916
	addiw	a0, a0, -1044
	sd	a0, 144(sp)                     # 8-byte Folded Spill
.LBB0_39:                               # %"for deconvolution.s0.c"
                                        # =>This Loop Header: Depth=1
                                        #     Child Loop BB0_40 Depth 2
                                        #       Child Loop BB0_41 Depth 3
                                        #         Child Loop BB0_42 Depth 4
                                        #           Child Loop BB0_43 Depth 5
                                        #             Child Loop BB0_44 Depth 6
                                        #               Child Loop BB0_45 Depth 7
	li	t5, 0
	ld	a0, 88(sp)                      # 8-byte Folded Reload
	mulw	a0, a0, t0
	ld	a1, 80(sp)                      # 8-byte Folded Reload
	subw	t3, a0, a1
	mv	a6, a7
.LBB0_40:                               # %"for deconvolution.s0.d"
                                        #   Parent Loop BB0_39 Depth=1
                                        # =>  This Loop Header: Depth=2
                                        #       Child Loop BB0_41 Depth 3
                                        #         Child Loop BB0_42 Depth 4
                                        #           Child Loop BB0_43 Depth 5
                                        #             Child Loop BB0_44 Depth 6
                                        #               Child Loop BB0_45 Depth 7
	li	s6, 0
	ld	a0, 136(sp)                     # 8-byte Folded Reload
	mulw	s2, a0, t5
	add	s2, s2, t3
	mv	t4, a6
.LBB0_41:                               # %"for deconvolution.s0.y"
                                        #   Parent Loop BB0_39 Depth=1
                                        #     Parent Loop BB0_40 Depth=2
                                        # =>    This Loop Header: Depth=3
                                        #         Child Loop BB0_42 Depth 4
                                        #           Child Loop BB0_43 Depth 5
                                        #             Child Loop BB0_44 Depth 6
                                        #               Child Loop BB0_45 Depth 7
	li	s11, 0
	ld	a0, 160(sp)                     # 8-byte Folded Reload
	mulw	a0, a0, s6
	add	a0, a0, s2
	subw	s4, a0, t6
	mv	s5, t4
.LBB0_42:                               # %"for deconvolution.s0.x"
                                        #   Parent Loop BB0_39 Depth=1
                                        #     Parent Loop BB0_40 Depth=2
                                        #       Parent Loop BB0_41 Depth=3
                                        # =>      This Loop Header: Depth=4
                                        #           Child Loop BB0_43 Depth 5
                                        #             Child Loop BB0_44 Depth 6
                                        #               Child Loop BB0_45 Depth 7
	li	s0, 0
	mv	s8, s5
	mv	s9, s10
	fmv.s	ft1, ft0
.LBB0_43:                               # %"for sum.s1.r26$z"
                                        #   Parent Loop BB0_39 Depth=1
                                        #     Parent Loop BB0_40 Depth=2
                                        #       Parent Loop BB0_41 Depth=3
                                        #         Parent Loop BB0_42 Depth=4
                                        # =>        This Loop Header: Depth=5
                                        #             Child Loop BB0_44 Depth 6
                                        #               Child Loop BB0_45 Depth 7
	li	s1, 0
	mv	a2, s8
	mv	a1, s9
.LBB0_44:                               # %"for sum.s1.r26$y"
                                        #   Parent Loop BB0_39 Depth=1
                                        #     Parent Loop BB0_40 Depth=2
                                        #       Parent Loop BB0_41 Depth=3
                                        #         Parent Loop BB0_42 Depth=4
                                        #           Parent Loop BB0_43 Depth=5
                                        # =>          This Loop Header: Depth=6
                                        #               Child Loop BB0_45 Depth 7
	li	a4, 4
	mv	a0, a2
	mv	a5, a1
.LBB0_45:                               # %"for sum.s1.r26$x"
                                        #   Parent Loop BB0_39 Depth=1
                                        #     Parent Loop BB0_40 Depth=2
                                        #       Parent Loop BB0_41 Depth=3
                                        #         Parent Loop BB0_42 Depth=4
                                        #           Parent Loop BB0_43 Depth=5
                                        #             Parent Loop BB0_44 Depth=6
                                        # =>            This Inner Loop Header: Depth=7
	flw	ft2, 0(a0)
	flw	ft3, 0(a5)
	fmadd.s	ft1, ft3, ft2, ft1
	addi	a4, a4, -1
	addi	a5, a5, 4
	addi	a0, a0, -4
	bnez	a4, .LBB0_45
# %bb.46:                               # %"end for sum.s1.r26$x"
                                        #   in Loop: Header=BB0_44 Depth=6
	addi	s1, s1, 1
	addi	a1, a1, 16
	addi	a2, a2, -812
	bne	s1, a3, .LBB0_44
# %bb.47:                               # %"end for sum.s1.r26$y"
                                        #   in Loop: Header=BB0_43 Depth=5
	addi	s0, s0, 1
	addi	s9, s9, 64
	add	s8, s8, ra
	bne	s0, a3, .LBB0_43
# %bb.48:                               # %"consume sum"
                                        #   in Loop: Header=BB0_42 Depth=4
	add	a0, s11, s4
	slli	a0, a0, 2
	add	a0, a0, s3
	fsw	ft1, 0(a0)
	addi	s11, s11, 1
	addi	s5, s5, 4
	bne	s11, s7, .LBB0_42
# %bb.49:                               # %"end for deconvolution.s0.x"
                                        #   in Loop: Header=BB0_41 Depth=3
	addi	s6, s6, 1
	addi	t4, t4, 812
	bne	s6, s7, .LBB0_41
# %bb.50:                               # %"end for deconvolution.s0.y"
                                        #   in Loop: Header=BB0_40 Depth=2
	addi	t5, t5, 1
	add	a6, a6, t2
	bne	t5, t1, .LBB0_40
# %bb.51:                               # %"end for deconvolution.s0.d"
                                        #   in Loop: Header=BB0_39 Depth=1
	addi	t0, t0, 1
	ld	a0, 144(sp)                     # 8-byte Folded Reload
	add	a7, a7, a0
	bne	t0, a3, .LBB0_39
# %bb.52:                               # %call_destructor.exit186
	li	a0, 0
	ld	a1, 152(sp)                     # 8-byte Folded Reload
	call	halide_free@plt
.LBB0_53:                               # %destructor_block
	li	a0, 0
	ld	ra, 440(sp)                     # 8-byte Folded Reload
	ld	s0, 432(sp)                     # 8-byte Folded Reload
	ld	s1, 424(sp)                     # 8-byte Folded Reload
	ld	s2, 416(sp)                     # 8-byte Folded Reload
	ld	s3, 408(sp)                     # 8-byte Folded Reload
	ld	s4, 400(sp)                     # 8-byte Folded Reload
	ld	s5, 392(sp)                     # 8-byte Folded Reload
	ld	s6, 384(sp)                     # 8-byte Folded Reload
	ld	s7, 376(sp)                     # 8-byte Folded Reload
	ld	s8, 368(sp)                     # 8-byte Folded Reload
	ld	s9, 360(sp)                     # 8-byte Folded Reload
	ld	s10, 352(sp)                    # 8-byte Folded Reload
	ld	s11, 344(sp)                    # 8-byte Folded Reload
	addi	sp, sp, 448
	ret
.LBB0_54:                               # %after_bb4.land.rhs.i161_crit_edge
	ld	a5, 0(a2)
	j	.LBB0_12
.Lfunc_end0:
	.size	deconvolution, .Lfunc_end0-deconvolution
                                        # -- End function
	.section	.text.deconvolution_argv,"ax",@progbits
	.globl	deconvolution_argv              # -- Begin function deconvolution_argv
	.p2align	1
	.type	deconvolution_argv,@function
deconvolution_argv:                     # @deconvolution_argv
# %bb.0:                                # %entry
	addi	sp, sp, -16
	sd	ra, 8(sp)                       # 8-byte Folded Spill
	ld	a2, 0(a0)
	ld	a1, 8(a0)
	mv	a0, a2
	call	deconvolution@plt
	li	a0, 0
	ld	ra, 8(sp)                       # 8-byte Folded Reload
	addi	sp, sp, 16
	ret
.Lfunc_end1:
	.size	deconvolution_argv, .Lfunc_end1-deconvolution_argv
                                        # -- End function
	.section	.text.deconvolution_metadata,"ax",@progbits
	.globl	deconvolution_metadata          # -- Begin function deconvolution_metadata
	.p2align	1
	.type	deconvolution_metadata,@function
deconvolution_metadata:                 # @deconvolution_metadata
# %bb.0:                                # %entry
.Lpcrel_hi1:
	auipc	a0, %pcrel_hi(.Ldeconvolution_metadata_storage)
	addi	a0, a0, %pcrel_lo(.Lpcrel_hi1)
	ret
.Lfunc_end2:
	.size	deconvolution_metadata, .Lfunc_end2-deconvolution_metadata
                                        # -- End function
	.type	.Lweights.shape,@object         # @weights.shape
	.section	.rodata,"a",@progbits
	.p2align	5, 0x0
.Lweights.shape:
	.asciz	"\000\000\000\000\004\000\000\000\001\000\000\000\000\000\000\000\000\000\000\000\004\000\000\000\004\000\000\000\000\000\000\000\000\000\000\000\004\000\000\000\020\000\000\000\000\000\000"
	.size	.Lweights.shape, 48

	.type	.Lweights.data,@object          # @weights.data
	.p2align	5, 0x0
.Lweights.data:
	.ascii	"\303\365\233?s\361\016\300\fL\227\276\\\344\321>~\322\337\2774\237x\276:\271\242>\335YN\277\304\327\001?\330\3019?/\320\006\277\000\357\244\275\261\277\243\277I\305s\277.r\222\277\322(\"\277A\257\231\276\251:\003@\267)\317=)\323\213\277\017\230\003\27715\024\300\013\241\204?o\0175?L#\271?;\265\322>\270Jw>/K\263=\303,/\277\3472\223?H\";>\241\326\367>\244\301C>N\213s?b&\345\2777\0067>P\r8\276\022\316\204?\331;\312?\235\367\337\275lq\013\277T\251h?\316\257\227<\361\002#\276B\220\305\277,\302\263\276\235\225\274?a64\276\005\2409><\330\204\277-\253\216\276\320\267R?\247\221\220?\354\340\246>\374)\263?8),?\310\321D?uN\275>x\253B\277iZ\213\2737#\315\277\267\235\305>\247\341r\277_\217\273\275"
	.size	.Lweights.data, 256

	.type	.Lweights.buffer,@object        # @weights.buffer
	.data
	.p2align	4, 0x0
.Lweights.buffer:
	.quad	0                               # 0x0
	.quad	0
	.quad	.Lweights.data
	.quad	1                               # 0x1
	.byte	2                               # 0x2
	.byte	32                              # 0x20
	.half	1                               # 0x1
	.word	3                               # 0x3
	.quad	.Lweights.shape
	.quad	0
	.size	.Lweights.buffer, 56

	.type	.Lstr,@object                   # @str
	.section	.rodata,"a",@progbits
	.p2align	5, 0x0
.Lstr:
	.asciz	"input"
	.size	.Lstr, 6

	.type	.L__unnamed_1,@object           # @0
	.p2align	3, 0x0
.L__unnamed_1:
	.quad	0                               # 0x0
	.size	.L__unnamed_1, 8

	.type	.L__unnamed_2,@object           # @1
	.p2align	3, 0x0
.L__unnamed_2:
	.quad	200                             # 0xc8
	.size	.L__unnamed_2, 8

	.type	.L__unnamed_3,@object           # @2
	.p2align	3, 0x0
.L__unnamed_3:
	.quad	0                               # 0x0
	.size	.L__unnamed_3, 8

	.type	.L__unnamed_4,@object           # @3
	.p2align	3, 0x0
.L__unnamed_4:
	.quad	200                             # 0xc8
	.size	.L__unnamed_4, 8

	.type	.L__unnamed_5,@object           # @4
	.p2align	3, 0x0
.L__unnamed_5:
	.quad	0                               # 0x0
	.size	.L__unnamed_5, 8

	.type	.L__unnamed_6,@object           # @5
	.p2align	3, 0x0
.L__unnamed_6:
	.quad	144                             # 0x90
	.size	.L__unnamed_6, 8

	.type	.L__unnamed_7,@object           # @6
	.p2align	3, 0x0
.L__unnamed_7:
	.quad	0                               # 0x0
	.size	.L__unnamed_7, 8

	.type	.L__unnamed_8,@object           # @7
	.p2align	3, 0x0
.L__unnamed_8:
	.quad	4                               # 0x4
	.size	.L__unnamed_8, 8

	.type	.L__unnamed_9,@object           # @8
	.section	.data.rel.ro,"aw",@progbits
	.p2align	4, 0x0
.L__unnamed_9:
	.quad	.L__unnamed_1
	.quad	.L__unnamed_2
	.quad	.L__unnamed_3
	.quad	.L__unnamed_4
	.quad	.L__unnamed_5
	.quad	.L__unnamed_6
	.quad	.L__unnamed_7
	.quad	.L__unnamed_8
	.size	.L__unnamed_9, 64

	.type	.Lstr.4,@object                 # @str.4
	.section	.rodata,"a",@progbits
	.p2align	5, 0x0
.Lstr.4:
	.asciz	"deconvolution"
	.size	.Lstr.4, 14

	.type	.L__unnamed_10,@object          # @9
	.section	.data.rel.ro,"aw",@progbits
	.p2align	4, 0x0
.L__unnamed_10:
	.quad	.Lstr
	.word	1                               # 0x1
	.word	4                               # 0x4
	.byte	2                               # 0x2
	.byte	32                              # 0x20
	.half	1                               # 0x1
	.zero	4
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	.Lstr.4
	.word	2                               # 0x2
	.word	4                               # 0x4
	.byte	2                               # 0x2
	.byte	32                              # 0x20
	.half	1                               # 0x1
	.zero	4
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	.L__unnamed_9
	.size	.L__unnamed_10, 128

	.type	.Lstr.5,@object                 # @str.5
	.section	.rodata,"a",@progbits
	.p2align	5, 0x0
.Lstr.5:
	.asciz	"riscv-64-linux-no_asserts-no_runtime"
	.size	.Lstr.5, 37

	.type	.Ldeconvolution_metadata_storage,@object # @deconvolution_metadata_storage
	.section	.data.rel.ro,"aw",@progbits
	.p2align	4, 0x0
.Ldeconvolution_metadata_storage:
	.word	1                               # 0x1
	.word	2                               # 0x2
	.quad	.L__unnamed_10
	.quad	.Lstr.5
	.quad	.Lstr.4
	.size	.Ldeconvolution_metadata_storage, 32

	.ident	"clang version 16.0.0 (https://github.com/dkurt/llvm-rvv-071 b027aa1b59c9f53240bdc836f39656723fdf9df0)"
	.ident	"clang version 16.0.0 (https://github.com/dkurt/llvm-rvv-071 b027aa1b59c9f53240bdc836f39656723fdf9df0)"
	.ident	"clang version 16.0.0 (https://github.com/dkurt/llvm-rvv-071 b027aa1b59c9f53240bdc836f39656723fdf9df0)"
	.ident	"clang version 16.0.0 (https://github.com/dkurt/llvm-rvv-071 b027aa1b59c9f53240bdc836f39656723fdf9df0)"
	.ident	"clang version 16.0.0 (https://github.com/dkurt/llvm-rvv-071 b027aa1b59c9f53240bdc836f39656723fdf9df0)"
	.ident	"clang version 16.0.0 (https://github.com/dkurt/llvm-rvv-071 b027aa1b59c9f53240bdc836f39656723fdf9df0)"
	.section	".note.GNU-stack","",@progbits
